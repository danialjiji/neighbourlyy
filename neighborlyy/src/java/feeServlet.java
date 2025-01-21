/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import bean.FeeBean;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
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
 * @author junmee
 */
@MultipartConfig
@WebServlet(urlPatterns = {"/feeServlet"})
public class feeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
            String accessType = request.getParameter("accessType");
   
        if ("addFee".equalsIgnoreCase(accessType)) {
            addFee(request, response);
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
    
        private void addFee(HttpServletRequest request, HttpServletResponse response) 
                throws IOException, ServletException {
        
        String feeTypestr = request.getParameter("feeType");
        double amount = Double.parseDouble (request.getParameter("amount"));
        String date = request.getParameter("dateFee");
        String useridStr = request.getParameter("userid");

        if (    feeTypestr == null || feeTypestr.trim().isEmpty() ||
                date == null || date.trim().isEmpty() ||
                amount <= 0 ){
            request.setAttribute("message", "Please insert all values");
            request.setAttribute("errorType", "addFee");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        try {
            int userid = Integer.parseInt(useridStr);
            int feeType = Integer.parseInt(feeTypestr);
            java.sql.Date sqlDate = java.sql.Date.valueOf(date);
            Part filePart = request.getPart("receipt");
            if (filePart == null) {
                request.setAttribute("message", "No file uploaded");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            String fileName = filePart.getSubmittedFileName();
            InputStream fileContent = filePart.getInputStream();
            
            FeeBean fee = new FeeBean();
            fee.setFeeType(feeType);
            fee.setAmount(amount);
            fee.setDateFee(sqlDate);
            fee.setReceipt(fileName);
            
            
             int statusid = 50001;

            // Use the helper method to get a connection
            try (Connection conn = DBConnection.createConnection()) {
                String query = "INSERT INTO Fee (USERID, FEE_CATEGORY_ID, STATUSID, FEE_DATE, FEE_AMOUNT, ATTACHMENT) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, userid);
                stmt.setInt(2, feeType);
                stmt.setInt(3, statusid);
                stmt.setDate (4, sqlDate);
                stmt.setDouble(5, amount);
                stmt.setString(6, fileName);
                stmt.executeUpdate();
            }

            response.sendRedirect("/neighborlyy/Resident/fee.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid user ID format");
           // request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) { // Catch any Exception that may occur
            if (e instanceof ClassNotFoundException) {
                // Handle ClassNotFoundException specifically
                System.out.println("Oracle JDBC Driver not found.");
            } else if (e instanceof SQLException) {
                // Handle SQLException specifically
                System.out.println("A database error occurred: " + e.getMessage());
            } else {
                // Handle other exceptions
                System.out.println("An unexpected error occurred: " + e.getMessage());
            }

            e.printStackTrace(); // Print the stack trace for debugging
            request.setAttribute("message", "An error occurred while processing your request");
            //request.getRequestDispatcher("error.jsp").forward(request, response);
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
