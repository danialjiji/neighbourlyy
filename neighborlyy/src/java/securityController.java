/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.sql.Timestamp;
import util.DBConnection; // Import the DBConnection class


/**
 *
 * @author USER
 */
public class securityController extends HttpServlet {

     protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String accessType = request.getParameter("accessType");

        switch (accessType) {
            case "addReport":
                handleAddReport(request, response);
                break;
            case "deleteReport":
                handleDeleteReport(request, response);
                break;
            case "addVisitor":
                handleAddVisitor(request, response);
                break;
            case "editVisitor":
                handleEditVisitor(request, response);
                break;
            case "deleteVisitor":
                handleDeleteVisitor(request, response);
                break;
            default:
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

    private void handleAddReport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String dateReport = request.getParameter("dateReport");
        String location = request.getParameter("location");
        String remarks = request.getParameter("remarks");
        String useridStr = request.getParameter("userid");

        if (dateReport == null || dateReport.trim().isEmpty() ||
            location == null || location.trim().isEmpty() ||
            remarks == null || remarks.trim().isEmpty()) {
            request.setAttribute("message", "Please insert all values");
            request.setAttribute("errorType", "addReport");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        try {
            int userid = Integer.parseInt(useridStr);
            Part filePart = request.getPart("attachment");
            if (filePart == null) {
                request.setAttribute("message", "No file uploaded");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            InputStream fileContent = filePart.getInputStream();

            try (Connection conn = DBConnection.createConnection()) {
                String query = "INSERT INTO Report (USERID, DATEOFVISIT, LOCATION, REMARKS, ATTACHMENT) VALUES (?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, userid);
                stmt.setString(2, dateReport);
                stmt.setString(3, location);
                stmt.setString(4, remarks);
                stmt.setBlob(5, fileContent);
                stmt.executeUpdate();
            }

            request.setAttribute("message", "Data successfully submitted");
            request.setAttribute("type", "addReport");
            request.getRequestDispatcher("success.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid user ID format");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while processing your request");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void handleAddVisitor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String visitorName = request.getParameter("visitorname");
        String icPassport = request.getParameter("icpassport");
        String plateNo = request.getParameter("plateno");
        String entryTime = request.getParameter("entrytime");
        String dateVisit = request.getParameter("datevisit");
        String purposeVisit = request.getParameter("purposevisit");
        String phoneNo = request.getParameter("phoneno");
        String useridStr = request.getParameter("userid");

        if (visitorName == null || visitorName.trim().isEmpty() ||
            icPassport == null || icPassport.trim().isEmpty() ||
            plateNo == null || plateNo.trim().isEmpty() ||
            entryTime == null || entryTime.trim().isEmpty() ||
            dateVisit == null || dateVisit.trim().isEmpty() ||
            purposeVisit == null || purposeVisit.trim().isEmpty() ||
            phoneNo == null || phoneNo.trim().isEmpty()) {
            request.setAttribute("message", "Please insert all values");
            request.setAttribute("errorType", "addVisitor");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        try {
            int userid = Integer.parseInt(useridStr);

            try (Connection conn = DBConnection.createConnection()) {
                String query = "INSERT INTO VISITOR (USERID, VISITOR_NAME, VISITOR_IC, NO_PLATE, ENTRYTIME, EXITTIME, DATEOFVISIT, PURPOSEOFVISIT, VISITOR_PHONENUM) VALUES (?, ?, ?, ?, TO_TIMESTAMP(?, 'HH24:MI'), ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, userid);
                stmt.setString(2, visitorName);
                stmt.setString(3, icPassport);
                stmt.setString(4, plateNo);
                stmt.setString(5, entryTime);
                stmt.setString(6, null);
                stmt.setString(7, dateVisit);
                stmt.setString(8, purposeVisit);
                stmt.setString(9, phoneNo);
                stmt.executeUpdate();
            }

            request.setAttribute("message", "Data successfully submitted");
            request.setAttribute("type", "addVisitor");
            request.getRequestDispatcher("success.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid user ID format");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while processing your request");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void handleDeleteReport(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reportIdStr = request.getParameter("id");

        if (reportIdStr == null || reportIdStr.trim().isEmpty()) {
            request.setAttribute("message", "Invalid report ID");
            request.setAttribute("errorType", "deleteReport");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        try {
            int reportId = Integer.parseInt(reportIdStr);

            try (Connection conn = DBConnection.createConnection()) {
                String query = "DELETE FROM Report WHERE REPORTID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, reportId);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    request.setAttribute("message", "Report successfully deleted");
                    request.getRequestDispatcher("success.jsp").forward(request, response);
                } else {
                    request.setAttribute("message", "Report not found");
                    request.setAttribute("errorType", "deleteReport");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid report ID format");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while deleting the report");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void handleEditVisitor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String visitorIdStr = request.getParameter("id");

        if (visitorIdStr == null || visitorIdStr.trim().isEmpty()) {
            request.setAttribute("message", "Visitor ID is required to update exit time");
            request.setAttribute("errorType", "editVisitor");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        try {
            int visitorId = Integer.parseInt(visitorIdStr);
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());

            try (Connection conn = DBConnection.createConnection()) {
                String query = "UPDATE VISITOR SET EXITTIME = ? WHERE REGISTERID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setTimestamp(1, currentTime);
                stmt.setInt(2, visitorId);

                int rowsUpdated = stmt.executeUpdate();
                if (rowsUpdated > 0) {
                    request.setAttribute("message", "Exit time successfully updated for Visitor ID: " + visitorId);
                    request.getRequestDispatcher("VisitorTable.jsp").forward(request, response);
                } else {
                    request.setAttribute("message", "No visitor found with the specified ID");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid Visitor ID format");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while updating the visitor");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    private void handleDeleteVisitor(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String registerIdStr = request.getParameter("id");

        if (registerIdStr == null || registerIdStr.trim().isEmpty()) {
            request.setAttribute("message", "Invalid Visitor ID");
            request.setAttribute("errorType", "deleteVisitor");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        try {
            int registerId = Integer.parseInt(registerIdStr);

            try (Connection conn = DBConnection.createConnection()) {
                String query = "DELETE FROM VISITOR WHERE REGISTERID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, registerId);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    request.setAttribute("message", "Visitor successfully deleted");
                    request.getRequestDispatcher("success.jsp").forward(request, response);
                } else {
                    request.setAttribute("message", "Visitor not found");
                    request.setAttribute("errorType", "deleteVisitor");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid Visitor ID format");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while deleting the visitor");
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
