/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bean.UserBean;
import dao.UserDao;
import util.DBConnection;
import java.util.List;

/**
 *
 * @author USER
 */

public class UserServlet extends HttpServlet {

    UserDao userDao = new UserDao();  
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        // Retrieve all users from the database using UserDao  
        List<UserBean> users = userDao.getAllUsers();  
        request.setAttribute("userList", users); // Store the list in request scope  
        
        // Forward to the JSP page to display the user list  
        request.getRequestDispatcher("listuser.jsp").forward(request, response);  
    }  

    protected void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        String action = request.getParameter("action");  

        if ("edit".equals(action)) {  
            int userID = Integer.parseInt(request.getParameter("userID"));  
            UserBean user = userDao.getUserById(userID);  
            request.setAttribute("user", user);  
            request.getRequestDispatcher("edituser.jsp").forward(request, response); 
            
        } else if ("delete".equals(action)) {  
            int userID = Integer.parseInt(request.getParameter("userID"));  
            userDao.deleteUser(userID);  
            response.sendRedirect("listUsers"); 
            
        } else if ("update".equals(action)) {  
            UserBean user = new UserBean();  
            user.setUserID(Integer.parseInt(request.getParameter("userID")));  
            user.setUsername(request.getParameter("username"));  
            user.setName(request.getParameter("name"));  
            user.setIc_passport(request.getParameter("ic_passport"));  
            user.setPhoneNum(request.getParameter("phoneNum"));  
            user.setEmail(request.getParameter("email"));  
            user.setPlate_id(request.getParameter("plate_id"));  
            user.setUserType(request.getParameter("user_type"));  

            // Handle specific fields based on user type  
            switch (user.getUserType()) {  
                case "admin":  
                    user.setSalary(request.getParameter("salary"));  
                    break;  
                case "guard":  
                    user.setShift(request.getParameter("shift"));  
                    user.setPostLocation(request.getParameter("postLocation"));  
                    break;  
                case "resident":  
                    user.setUnitHouse(request.getParameter("unitHouse"));  
                    break;  
            }  

            userDao.updateUser(user);  
            response.sendRedirect("listuser.jsp");  
        }  
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
