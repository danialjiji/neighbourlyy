import bean.ReportBean;
import bean.VisitorBean;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import static jdk.nashorn.tools.ShellFunctions.input;
import util.DBConnection;
import java.io.InputStream;


@MultipartConfig
@WebServlet(urlPatterns = {"/securityController"})
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
    
    //Add Rounding Report Form
    private void handleAddReport(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
        String dateReport = request.getParameter("dateReport");
        String location = request.getParameter("location");
        String remarks = request.getParameter("remarks");
        String useridStr = request.getParameter("userid");
        

        try {
            int userid = Integer.parseInt(useridStr);
            Part filePart = request.getPart("attachment");
            
            String fileName = filePart.getSubmittedFileName();
            
            //for uploading file into specific folder
            String uploadDirectory = "C:/Users/Nurin Atikah/Documents/GitHub/neighbourlyy/neighborlyy/web/Guard/attachment";

            try (InputStream input = filePart.getInputStream()) {
                Path filePath = Paths.get(uploadDirectory, fileName);
                Files.copy(input, filePath, StandardCopyOption.REPLACE_EXISTING);
            } 


            
            ReportBean report = new ReportBean();
            report.setDateofvisit(dateReport);
            report.setLocation(location);
            report.setRemarks(remarks);
            report.setAttachment(fileName);
            report.setUserid(userid);

            try (Connection conn = DBConnection.createConnection()) {
                String query = "INSERT INTO Report (USERID, DATEOFVISIT, \"location\", REMARKS, ATTACHMENT) VALUES (?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, report.getUserid());
                stmt.setString(2, report.getDateofvisit());
                stmt.setString(3, report.getLocation());
                stmt.setString(4, report.getRemarks());
                stmt.setString(5, report.getAttachment());
                stmt.executeUpdate();
            }
            
            response.sendRedirect("./Guard/RoundingReport.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (Exception e) { 
            if (e instanceof SQLException) {
            }
            e.printStackTrace();
        }

    }
    
    //Add Visitor Form
    VisitorBean visitor = new VisitorBean();
    private void handleAddVisitor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String visitorName = request.getParameter("visitorname");
        String icPassport = request.getParameter("icpassport");
        String plateNo = request.getParameter("plateno");
        String entryTime = request.getParameter("entrytime");
        String dateVisit = request.getParameter("datevisit");
        String purposeVisit = request.getParameter("purposevisit");
        String phoneNo = request.getParameter("phoneno");
        String useridStr = request.getParameter("userid");
        
        visitor.setVisitorname(visitorName);
        visitor.setIcpassport(icPassport);
        visitor.setPlateno(plateNo);
        visitor.setEntrytime(entryTime);
        visitor.setDatevisit(dateVisit);
        visitor.setExittime(null);
        visitor.setPurposevisit(purposeVisit);
        visitor.setPhoneno(phoneNo);


        try {
            int userid = Integer.parseInt(useridStr);
            visitor.setUserid(userid);
            
            try (Connection conn = DBConnection.createConnection()) {
                String query = "INSERT INTO VISITOR (USERID, VISITOR_NAME, VISITOR_IC, NO_PLATE, ENTRYTIME, EXITTIME, DATEOFVISIT, PURPOSEOFVISIT, VISITOR_PHONENUM) VALUES (?, ?, ?, ?, TO_TIMESTAMP(?, 'HH24:MI'), ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, visitor.getUserid());
                stmt.setString(2, visitor.getVisitorname());
                stmt.setString(3, visitor.getIcpassport());
                stmt.setString(4, visitor.getPlateno());
                stmt.setString(5, visitor.getEntrytime());
                stmt.setString(6, null);
                stmt.setString(7, visitor.getDatevisit());
                stmt.setString(8, visitor.getPurposevisit());
                stmt.setString(9, visitor.getPhoneno());
                stmt.executeUpdate();
            }

            response.sendRedirect("./Guard/VisitorForm.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid user ID format");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            } catch (Exception e) {
                if (e instanceof SQLException) {
                    System.out.println("A database error occurred: " + e.getMessage());
                } else {
                    System.out.println("An unexpected error occurred: " + e.getMessage());
                }
                e.printStackTrace();
                request.setAttribute("message", "An error occurred while processing your request");
        }
    }

    //Exit Visitor
    private void handleEditVisitor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String visitorIdStr = request.getParameter("id");


        try {
            int visitorId = Integer.parseInt(visitorIdStr);

            java.sql.Timestamp currentTime = new java.sql.Timestamp(System.currentTimeMillis());
            String exittime = currentTime.toString();
            visitor.setExittime(exittime);
            

            try (Connection conn = DBConnection.createConnection()) {
                String query = "UPDATE VISITOR SET EXITTIME = ? WHERE REGISTERID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setTimestamp(1, currentTime);
                stmt.setInt(2, visitorId);

                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("./Guard/VisitorForm.jsp");
                } else {
                    request.setAttribute("message", "No visitor found with the specified ID");
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid Visitor ID format");
        } catch (Exception e) {
            if (e instanceof SQLException) {
                System.out.println("A database error occurred: " + e.getMessage());
            } else {
                System.out.println("An unexpected error occurred: " + e.getMessage());
            }
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while updating the visitor");
        }
    }

    //Delete Report
    private void handleDeleteReport(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String reportIdStr = request.getParameter("id");

        try {
            int reportId = Integer.parseInt(reportIdStr);

            // Use the helper method to get a connection
            try (Connection conn = DBConnection.createConnection()) {
                String query = "DELETE FROM Report WHERE REPORTID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, reportId);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("./Guard/RoundingReport.jsp");
                } else {
                    request.setAttribute("message", "Report not found");
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid report ID format");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while deleting the report");
        }
    }
    
    //Delete Visitor
    private void handleDeleteVisitor(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String registerIdStr = request.getParameter("id");

        try {
            int reportId = Integer.parseInt(registerIdStr);

            // Use the helper method to get a connection
            try (Connection conn = DBConnection.createConnection()) {
                String query = "DELETE FROM Visitor WHERE REGISTERID = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setInt(1, reportId);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("./Guard/VisitorForm.jsp");
                } else {
                    request.setAttribute("message", "Report not found");
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("message", "Invalid report ID format");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred while deleting the report");
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
