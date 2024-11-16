<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, dao.*, bean.*"%>
<%
    // Get the productId and quantity from the request
    int productId = Integer.parseInt(request.getParameter("productId"));
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    String email = (String) session.getAttribute("userEmail");

    if (email == null) {
        response.sendRedirect("log.jsp"); // If user is not logged in, redirect to login page
        return;
    }

    // Fetch user ID based on email (Assuming userRegID is related to email)
    UserRegistrationDAO userDAO = new UserRegistrationDAO();
    int userRegID = userDAO.getUserIDByEmail(email); // Fetch user ID from database based on email

    // Check if the product exists and get product details
    ProductDAO productDAO = new ProductDAO();
    ProductBean product = productDAO.getProductById(productId);

    if (product == null) {
        out.println("<div class='alert' style='border: 1px solid #ccc; padding: 10px;'>Product not found.</div>");
        return;
    }

    // Get the price of the product (either discounted or normal price)
    double price = product.getPrice();
    
    // Check if the product is already in the cart for the logged-in user
    CartDAO cartDAO = new CartDAO();
    CartItem existingCartItem = cartDAO.getCartItem(userRegID, productId); // Use userRegID for cart check

    // If the product already exists in the cart, update the quantity
    if (existingCartItem != null) {
        // Update cart item with the new quantity
        existingCartItem.setQuantity(existingCartItem.getQuantity() + quantity);
        existingCartItem.setPrice(price); // Update price in case of any discount changes
        cartDAO.updateCartItem(existingCartItem); // Pass the whole CartItem object to update
    } else {
        // Insert new product into cart
        CartItem newItem = new CartItem(userRegID, productId, product.getProductName(), quantity, price);
        cartDAO.addCartItem(newItem); // Add new item to the cart
    }

    // Send response back to the client
    response.setContentType("text/plain");
    out.println("Product added to cart.");
%>
