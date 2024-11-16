<%@page import="dao.UserRegistrationDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CartDAO" %>
<%@ page import="bean.CartItem" %>
<%@ page import="java.util.List" %>
<%
    // Retrieve the email of the logged-in user from session
    String email = (String) session.getAttribute("userEmail");
    
    // Redirect to login page if email is not available in session
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }
    
    UserRegistrationDAO dao=new UserRegistrationDAO();

    // Assuming a method to get the userRegID based on email (you need to implement this in your system)
    int userRegID = dao.getUserIDByEmail(email);

    // Fetch the cart items for the user
    CartDAO cartDAO = new CartDAO();
    List<CartItem> cartItems = cartDAO.getAllCartItems(userRegID);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sports World - Cart</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
        <a class="navbar-brand text-danger" href="#">Sports World</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <form class="d-flex" action="#" method="get">
                        <input class="form-control mr-2" type="search" placeholder="Search Materials" name="query" aria-label="Search">
                        <button class="btn btn-outline-danger ml-2" type="submit">Search</button>
                    </form>
                </li>
                <li class="nav-item"><a class="nav-link text-danger" href="home.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link text-danger" href="logout.jsp">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- Cart Section -->
    <div class="container my-5 flex-grow-1">
        <h2 class="text-center text-danger mb-4">Shopping Cart</h2>
        <div class="row">
            <div class="col-md-8">
                <!-- Loop through the cart items -->
                <%
                    if (cartItems != null && !cartItems.isEmpty()) {
                        for (CartItem cartItem : cartItems) {
                %>
                        <div class="card mb-3">
                            <div class="row no-gutters">
                                
                                <div class="col-md-8">
                                    <div class="card-body">
                                        <h5 class="card-title"><%= cartItem.getProductName() %></h5>
                                        <p class="card-text">Price: &#8377;<%= cartItem.getPrice() %></p>
                                        <input type="number" class="form-control mb-2" placeholder="Quantity" min="1" value="<%= cartItem.getQuantity() %>">
                                        <button class="btn btn-danger btn-sm" onclick="removeItem(<%= cartItem.getProductId() %>)">Remove</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                <%
                        }
                    } else {
                %>
                        <p class="text-center">Your cart is empty.</p>
                <%
                    }
                %>
            </div>

            <!-- Cart Summary -->
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title text-danger">Order Summary</h5>
                        <%
                            // Calculate total price of items in the cart
                            double totalPrice = cartDAO.getTotalPrice(userRegID);
                            double tax = totalPrice * 0.1;  // Assuming 10% tax
                            double total = totalPrice + tax;
                        %>
                        <p>Subtotal: &#8377;<%= totalPrice %></p>
                        <p>Tax: &#8377;<%= tax %></p>
                        <hr>
                        <h5>Total: &#8377;<%= total %></h5>
                        <a href="checkout.jsp" class="btn btn-danger btn-block">Proceed to Checkout</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-danger text-white text-center py-3 mt-auto">
        <p>&copy; 2024 Sports World. All Rights Reserved.</p>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<script>
    function removeItem(productId) {
        // Implement the remove item functionality using AJAX or form submission
        // Example: Send request to backend to remove item from the cart
        alert("Item with ID " + productId + " will be removed.");
    }
</script>
