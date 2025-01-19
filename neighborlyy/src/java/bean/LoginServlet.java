/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import bean.LoginBean;
import dao.LoginDao;

/**
 *
 * @author USER
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

          //retrive the data
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        LoginBean loginBean = new LoginBean(); 
        loginBean.setUsername(username);
        loginBean.setPassword(password);

        LoginDao loginDao = new LoginDao();
        String userValidation = loginDao.authenticateUser(loginBean);
       
        if (userValidation.equals("SUCCESS")) {
            // If login is successful, create a session and store user details
            HttpSession session = request.getSession();
            session.setAttribute("username", username);

            // Get the userID from the database
            int userId = loginDao.getUserId(username);
            session.setAttribute("userid", userId);

            // Check which table the user belongs to and redirect accordingly
            if (loginDao.isAdmin(userId)) {
                response.sendRedirect("dashboardAdmin.jsp");
            } else if (loginDao.isGuard(userId)) {
                response.sendRedirect("dashboardGuard.jsp");
            } else if (loginDao.isResident(userId)) {
                response.sendRedirect("dashboardResident.jsp");
            } else {
                // If the user does not belong to any specific table, redirect to an error page
                request.setAttribute("errorMessage", "User role not identified.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } else {
            // If login fails, redirect back to login.jsp with an error message
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
