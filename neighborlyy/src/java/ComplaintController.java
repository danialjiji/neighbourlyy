import bean.ComplaintBean;  
import bean.ComplaintBean2;
import java.io.IOException;  
import java.io.InputStream;  
import java.io.PrintWriter;  
import java.sql.*;  
import javax.servlet.ServletException;  
import javax.servlet.annotation.MultipartConfig;  
import javax.servlet.annotation.WebServlet;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.Part;  
import util.DBConnection;  
import java.util.Date;  
import java.text.SimpleDateFormat;  

@MultipartConfig  
public class ComplaintController extends HttpServlet {  

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {  
        response.setContentType("text/html;charset=UTF-8");  

        String accessType = request.getParameter("accessType");  

        try {  
            if (accessType.equals("update")) {  
                // Fetch parameters  
                String complaintID = request.getParameter("complaintID");  
                String userID = request.getParameter("userID");  
                String statusID = request.getParameter("statusID");  
                String complaintTypeID = request.getParameter("complaintTypeID");  
                String description = request.getParameter("description");  
                String complaintDate = request.getParameter("complaintDate"); // Expects format "yyyy-MM-dd"                   
                String location = request.getParameter("location");  

                // Prepare date parsing  
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
                java.util.Date parsedDate = dateFormat.parse(complaintDate);  
                java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());  

                try {  
                    Part filePart = request.getPart("attachment");  
                    String fileName = filePart.getSubmittedFileName();  
                    InputStream fileContent = filePart.getInputStream();  

                    // Bean setup  
                    ComplaintBean2 complaint = new ComplaintBean2(userID, statusID, complaintTypeID, description, complaintDate, location, fileName);

                    // Database Update Query  
                    Connection conn = DBConnection.createConnection();  
                    String sql = "UPDATE complaint SET userID=?, statusID=?, complaint_type_ID=?, " +  
                                 "complaint_description=?, complaint_date=TO_DATE(?, 'YYYY:MM:DD'), " +  
                                 "complaint_location=?, complaint_attachment=? WHERE complaintID=?";  
                    PreparedStatement stmt = conn.prepareStatement(sql);  

                    stmt.setInt(1, Integer.parseInt(complaint.getUserID()));  
                    stmt.setInt(2, Integer.parseInt(complaint.getStatusID()));  
                    stmt.setInt(3, Integer.parseInt(complaint.getComplaintTypeID()));  
                    stmt.setString(4, complaint.getComplaintDescription());  
                    stmt.setString(5, complaint.getComplaintDate()); // Correctly setting the SQL Date                     
                    stmt.setString(6, complaint.getComplaintLocation());  
                    stmt.setString(7, complaint.getComplaintAttachment());  
                    stmt.setInt(8, Integer.parseInt(complaintID));  

                    stmt.executeUpdate();  
                    // Properly close resources  
                    stmt.close();  
                    conn.close();  

                } catch (SQLException e) {  
                    System.out.println("A database error occurred: " + e.getMessage());  
                } catch (Exception e) {  
                    System.out.println("An unexpected error occurred: " + e.getMessage());  
                }  

                response.sendRedirect("./Admin/Complaint.jsp");  

            } else if (accessType.equals("delete")) {  
                String complaintID = request.getParameter("complaintID");  

                try {  
                    Connection conn = DBConnection.createConnection();  
                    PreparedStatement stmt = conn.prepareStatement("DELETE FROM complaint WHERE complaintID=?");  
                    stmt.setInt(1, Integer.parseInt(complaintID));  
                    stmt.executeUpdate();  
                    stmt.close();  
                    conn.close();  
                }  catch (SQLException e) {  
                    System.out.println("A database error occurred: " + e.getMessage());  
                } catch (Exception e) {  
                    System.out.println("An unexpected error occurred: " + e.getMessage());  
                }  

                response.sendRedirect("./Admin/Complaint.jsp");  
            }  

        } catch (Exception e) {  
            e.printStackTrace();  
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