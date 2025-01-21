/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import bean.RegisterGuardBean;
import dao.RegisterGuardDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author USER
 */
public class RegisterGuardServlet extends HttpServlet {

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
        // Get the form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String icNumber = request.getParameter("icNumber");
        String phoneNumber = request.getParameter("phoneNumber");
        String plateNumber = request.getParameter("plateNumber");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmpassword");
        String shift = request.getParameter("shift");
        String postLocation = request.getParameter("postLocation");

        // Check if the password and confirm password match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("registerGuard.jsp?error=Passwords do not match");
            return;
        }

        // Create RegisterBean object
        RegisterGuardBean registerGuardBean = new RegisterGuardBean();
        registerGuardBean.setName(name);
        registerGuardBean.setEmail(email);
        registerGuardBean.setIcNumber(icNumber);
        registerGuardBean.setPhoneNumber(phoneNumber);
        registerGuardBean.setPlateNumber(plateNumber);
        registerGuardBean.setUsername(username);
        registerGuardBean.setPassword(password);
        registerGuardBean.setShift(shift);
        registerGuardBean.setPostlocation(postLocation);
 

        // Call the RegisterDao to insert the user data into the database
        RegisterGuardDao registerDao = new RegisterGuardDao();
        boolean isRegistered = registerDao.registerUser(registerGuardBean);

        
        if (isRegistered) {  
            response.sendRedirect("dashboardAdmin.jsp");  
        } else {  
            request.setAttribute("error", "Registration failed");  
            RequestDispatcher dispatcher = request.getRequestDispatcher("registerGuard.jsp");  
            dispatcher.forward(request, response);  
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

