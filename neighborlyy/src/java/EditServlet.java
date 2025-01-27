/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;  
import javax.servlet.ServletException;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import dao.EditDao; // Adjust to your package  
import bean.EditBean; // Adjust to your package  

/**
 *
 * @author USER
 */
public class EditServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
     protected void doGet(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
        // Forward to edit user page for updating user details  
        int userID = Integer.parseInt(request.getParameter("userID"));  
        request.setAttribute("userID", userID);  
        request.getRequestDispatcher("editUser.jsp").forward(request, response);  
    }  

    protected void doPost(HttpServletRequest request, HttpServletResponse response)  
        throws ServletException, IOException {  
    String action = request.getParameter("action");  

    EditDao dao = new EditDao();  

    if ("update".equals(action)) {  
        int userID = Integer.parseInt(request.getParameter("userID"));  
        String username = request.getParameter("username");  
        String name = request.getParameter("name");  
        String icPassport = request.getParameter("ic_passport");  
        String phoneNum = request.getParameter("phoneNum");  
        String email = request.getParameter("email");  
        String plateNumber = request.getParameter("plateNumber");  

        // Initialize salary to 0 or handle error  
        double salary = Double.parseDouble(request.getParameter("salary"));
       
        
        String shift = request.getParameter("shift");   
        String postlocation = request.getParameter("postlocation");   
        String unit = request.getParameter("unit");  

        EditBean user = new EditBean();  
        user.setUserID(userID);  
        user.setUsername(username);  
        user.setName(name);  
        user.setIcPassport(icPassport);  
        user.setPhoneNum(phoneNum);  
        user.setEmail(email);  
        user.setPlateNumber(plateNumber);  
        user.setSalary(salary);  
        user.setShift(shift);  
        user.setPostlocation(postlocation);   
        user.setUnit(unit);  

        boolean success = dao.updateUser(user);  
        if (success) {  
            response.sendRedirect("./Admin/userllist1.jsp"); // Redirect back to user list  
        } else {  
            response.getWriter().print("Update failed!"); // Error message  
        }  
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