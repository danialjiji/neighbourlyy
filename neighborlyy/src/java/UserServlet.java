/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import bean.UserBean;
import dao.UserDao;
import java.util.List;
import java.util.ArrayList;
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
public class UserServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String action = request.getParameter("action");
    String category = request.getParameter("category");
    int userId;

    try {
        switch (action) {
            case "list":
                if (category == null || category.isEmpty()) category = "admin";
                List<UserBean> users = UserDao.getUsersByCategory(category);
                if (users == null) users = new ArrayList<>(); // Prevent null
                request.setAttribute("users", users);
                request.setAttribute("category", category);
                RequestDispatcher dispatcher = request.getRequestDispatcher("userlist.jsp");
                dispatcher.forward(request, response);
                break;

            case "edit":
                userId = Integer.parseInt(request.getParameter("userId"));
                UserBean user = UserDao.getUserByIdAndCategory(userId, category);
                if (user == null) {
                    request.setAttribute("error", "User not found!");
                    response.sendRedirect("UserServlet?action=list&category=" + category);
                    return;
                }
                request.setAttribute("user", user);
                RequestDispatcher editDispatcher = request.getRequestDispatcher("edituser.jsp");
                editDispatcher.forward(request, response);
                break;

            case "delete":
                userId = Integer.parseInt(request.getParameter("userId"));
                boolean isDeleted = UserDao.updateOrDeleteUser(userId, null, true, category);
                request.setAttribute("message", isDeleted ? "User deleted successfully." : "Failed to delete the user.");
                response.sendRedirect("UserServlet?action=list&category=" + category);
                break;

            default:
                response.sendRedirect("UserServlet?action=list");
                break;
        }
    } catch (Exception e) {
        request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
        e.printStackTrace();
        response.sendRedirect("error.jsp");
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
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
    
