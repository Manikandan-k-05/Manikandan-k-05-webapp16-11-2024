<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="dao.*,bean.*, java.util.*, java.sql.*"%>
<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String email = (String) session.getAttribute("userEmail");

if (email == null) {
	response.sendRedirect("log.jsp");
	return; // Exit the page
}

out.print(email); // Display the email if session is valid
%> --%>
<%
// Fetch categories from the database
List<ProductBean> productBeans = new ArrayList<>();
ProductDAO productDAO = new ProductDAO();

try {
	productBeans = productDAO.getAllProducts(); // Call the method to get categories from DB
	request.setAttribute("products", productBeans); // Set the product list as a request attribute
} catch (SQLException e) {
	out.println("Error fetching products: " + e.getMessage());
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product View</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.product-card {
    margin: 20px;
    border: none;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.2s, box-shadow 0.2s;
    height: 400px; /* Increased height of the card */
    display: flex;
    flex-direction: column;
    justify-content: space-between; /* Ensures even spacing between image, title, and button */
}

.product-card:hover {
    transform: translateY(-5px);
    box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.2);
}
.product-card img {
    height: 250px; /* Container height */
    width: 100%; /* Ensures it spans the full width */
    object-fit: contain; /* Keeps the aspect ratio intact and centers the image */
    display: block; /* Ensures the image is treated as a block element */
    margin: auto; /* Centers the image horizontally */
    border-top-left-radius: 5px;
    border-top-right-radius: 5px;
}

.product-card .card-body {
    text-align: center;
    padding: 15px;
}

.product-card .card-title {
    font-size: 1.2rem;
    font-weight: bold;
    margin-bottom: 10px;
    margin-top: 10px;
}


</style>
</head>
<body>
	<!-- Products Section -->
	<div class="container my-5">
		<h2 class="text-center text-danger mb-4">Popular Products</h2>
		<div class="row">
    <c:forEach var="product" items="${products}">
        <div class="col-md-4 mb-4">
            <a href="productDetail.jsp?productId=${product.productId}" class="text-decoration-none">
                <div class="card product-card">
                    <img src="uploads/${product.productImage}" class="card-img-top" alt="${product.productName}">
                    <div class="card-body">
                        <h5 class="card-title">${product.productName}</h5>
                        <a href="#" class="btn btn-danger">Buy Now</a>
                    </div>
                </div>
            </a>
        </div>
    </c:forEach>
</div>
		
	</div>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
