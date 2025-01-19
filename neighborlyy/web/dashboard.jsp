<%-- 
    Document   : dashboard.jsp
    Created on : Jan 19, 2025, 12:26:04 AM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
   <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Ubuntu:wght@300&display=swap" rel="stylesheet">
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="profile">
                <img style="height:60px; width:60x; margin-right: 10px;" src="assets/images/profile1.png" alt="logo"> 
                <h3>Hi, Danial</h3>
                
            </div>
            
            
            <nav class="menu">
                <ul>
                    <li class="active"><a href="#">Dashboard</a></li>
                    <li><a href="#">Basic UI Elements</a></li>
                    <li><a href="#">Icons</a></li>
                    <li><a href="#">Forms</a></li>
                    <li><a href="#">Charts</a></li>
                    <li><a href="#">Tables</a></li>
                    <li><a href="#">Sample Pages</a></li>
                    <li><a href="#" class="btn-add-project">+ Add a Project</a></li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <header>
                <h1>Dashboard</h1>
                <span>Overview</span>
            </header>

            <section class="cards">
                <div class="card">
                    <h2>Weekly Sales</h2>
                    <p class="amount">$15,000</p>
                    <p class="status increased">Increased by 60%</p>
                </div>
                <div class="card">
                    <h2>Weekly Orders</h2>
                    <p class="amount">45,6334</p>
                    <p class="status decreased">Decreased by 10%</p>
                </div>
                <div class="card">
                    <h2>Visitors Online</h2>
                    <p class="amount">95,5741</p>
                    <p class="status increased">Increased by 5%</p>
                </div>
            </section>

            <section class="charts">
                <div class="chart">
                    <h3>Visit And Sales Statistics</h3>
                    <div class="chart-placeholder">Bar Chart Placeholder</div>
                </div>
                <div class="chart">
                    <h3>Traffic Sources</h3>
                    <div class="chart-placeholder">Pie Chart Placeholder</div>
                </div>
            </section>
            
          <section class="data-table">
                    <h3>Recent Transactions</h3>
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Transaction ID</th>
                                <th>Customer</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#001</td>
                                <td>John Doe</td>
                                <td>$200</td>
                                <td>Completed</td>
                                <td>2025-01-18</td>
                                <td>
                                    <button class="btn-submit">Edit</button>
                                    <button class="btn-submit">Delete</button>
                                </td>
                            </tr>
                            <tr>
                                <td>#002</td>
                                <td>Jane Smith</td>
                                <td>$150</td>
                                <td>Pending</td>
                                <td>2025-01-17</td>
                            </tr>
                            <tr>
                                <td>#003</td>
                                <td>Mike Johnson</td>
                                <td>$300</td>
                                <td>Cancelled</td>
                                <td>2025-01-16</td>
                            </tr>
                        </tbody>
                    </table>
          </section>
            
        
             <div class="form-container">
                <h3>Basic Form Elements</h3>
                <p>Basic form elements</p>
                <form>
                <label for="name">Name</label>
                <input type="text" id="name" placeholder="Name">

                <label for="email">Email Address</label>
                <input type="email" id="email" placeholder="Email">

                <label for="password">Password</label>
                <input type="password" id="password" placeholder="Password">

                <label for="gender">Gender</label>
                <select id="gender">
                    <option>Male</option>
                    <option>Female</option>
                </select>

                <label for="upload">File Upload</label>
                <input type="file" id="upload">
                <button type="button" class="upload-btn">Upload</button>

                <label for="city">City</label>
                <input type="text" id="city" placeholder="Location">

                <label for="textarea">Textarea</label>
                <textarea id="textarea" placeholder=""></textarea>

                <div class="btn-container">
                    <button type="submit" class="btn-submit">Submit</button>
                    <button type="button" class="btn-cancel">Cancel</button>
                </div>
            </form>
        </div>

   
     </main>
   </div>
</body>
</html>
