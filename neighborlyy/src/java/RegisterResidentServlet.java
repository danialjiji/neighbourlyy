/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import bean.RegisterResidentBean;
import dao.RegisterResidentDao;
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
public class RegisterResidentServlet extends HttpServlet {

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
               // Get the form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String icNumber = request.getParameter("icNumber");
        String phoneNumber = request.getParameter("phoneNumber");
        String plateNumber = request.getParameter("plateNumber");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmpassword");
        String unitHouse = request.getParameter("unitHouse");

        // Check if the password and confirm password match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("registerResident.jsp?error=Passwords do not match");
            return;
        }

        // Create RegisterBean object
        RegisterResidentBean registerResidentBean = new RegisterResidentBean();
        registerResidentBean.setName(name);
        registerResidentBean.setEmail(email);
        registerResidentBean.setIcNumber(icNumber);
        registerResidentBean.setPhoneNumber(phoneNumber);
        registerResidentBean.setPlateNumber(plateNumber);
        registerResidentBean.setUsername(username);
        registerResidentBean.setPassword(password);
        registerResidentBean.setUnitHouse(unitHouse);
      
 

        // Call the RegisterDao to insert the user data into the database
        RegisterResidentDao registerDao = new RegisterResidentDao();
        boolean isRegistered = registerDao.registerUser(registerResidentBean);

        
        if (isRegistered) {  
            response.sendRedirect("dashboardAdmin.jsp");  
        } else {  
            request.setAttribute("error", "Registration failed");  
            RequestDispatcher dispatcher = request.getRequestDispatcher("registerResident.jsp");  
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
