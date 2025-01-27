/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import util.DBConnection;

/**
 *
 * @author soleha
 */
@MultipartConfig
@WebServlet(urlPatterns = {"/updateFeeServlet"})
public class updateFeeServlet extends HttpServlet {

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
       String accessType = request.getParameter("accessType");

       if ("payFee".equalsIgnoreCase(accessType)) {
            payFee(request, response);
        } else {
            try (PrintWriter out = response.getWriter()) {
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Invalid Access Type</title>");
                out.println("</head>");
                out.println("<body>");
                out.println("<h1>Invalid access type: " + accessType + "</h1>");
                out.println("</body>");
                out.println("</html>");
            }
        }
    }
    
     private void payFee(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
            double payfee = Double.parseDouble(request.getParameter("payFee"));
            String remark = request.getParameter("remark");
            String feeIdStr = request.getParameter("feeid");


        if (feeIdStr == null || feeIdStr.trim().isEmpty()) {
            request.setAttribute("message", "Fee ID is missing or invalid.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

            try {
                int feeId = Integer.parseInt(feeIdStr);
                Part filePart = request.getPart("receipt");
            if (filePart == null) {
                request.setAttribute("message", "No file uploaded");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            String fileName = filePart.getSubmittedFileName();
            InputStream fileContent = filePart.getInputStream();
            
                try (Connection conn = DBConnection.createConnection()) {
                    String query = "UPDATE fee SET attachment = ?, payfee = ?, remark = ? WHERE feeID = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(query)) {
                        stmt.setString(1, fileName);
                        stmt.setDouble(2, payfee);
                        stmt.setString(3, remark);
                        stmt.setInt(4, feeId);

                        int rowsUpdated = stmt.executeUpdate();

                        if (rowsUpdated > 0) {
                            response.sendRedirect("/neighborlyy/Resident/fee.jsp");
                        } else {
                            request.setAttribute("message", "No fee found with the given ID");
                            request.getRequestDispatcher("error.jsp").forward(request, response);
                        }
                    }
                }

            } catch (NumberFormatException e) {
                request.setAttribute("message", "Invalid fee ID format");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            } catch (Exception e) {
                 if (e instanceof SQLException) {
                    System.out.println("A database error occurred: " + e.getMessage());
                } else {
                    System.out.println("An unexpected error occurred: " + e.getMessage());
                }
                e.printStackTrace(); // Log error for debugging
                request.setAttribute("message", "An error occurred while processing your request");
                request.getRequestDispatcher("error.jsp").forward(request, response);
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
