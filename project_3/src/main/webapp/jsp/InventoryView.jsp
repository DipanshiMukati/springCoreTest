<%@page import="in.co.rays.project_3.controller.InventoryCtl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="in.co.rays.project_3.util.HTMLUtility"%>
<%@page import="in.co.rays.project_3.util.DataUtility"%>
<%@page import="in.co.rays.project_3.util.ServletUtility"%>
<%@page import="in.co.rays.project_3.controller.ORSView"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inventory view</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="<%=ORSView.APP_CONTEXT%>/js/utilities.js"></script>
<script>
	function validateNumberKey(event, validationMessageId) {
		// Allow only digits, minus sign, and dot for latitude and longitude input
		if (!/[0-9\-]/.test(event.key)) {
			// Show validation message
			var validationMsg = document.getElementById(validationMessageId);
			validationMsg.style.display = 'inline';
			event.preventDefault(); // Prevent typing the invalid character
		} else {
			// Hide validation message if input is valid
			var validationMsg = document.getElementById(validationMessageId);
			validationMsg.style.display = 'none';
		}
	}
</script>


<style type="text/css">
i.css {
	bInventory: 2px solid #8080803b;
	padding-left: 10px;
	padding-bottom: 11px;
	background-color: #ebebe0;
}

.input-group-addon {
	box-shadow: 9px 8px 7px #001a33;
	background-image: linear-gradient(to bottom right, white, pink);
	background-repeat: no repeat;
	background-size: 100%;
	padding-bottom: 11px;
}

.hm {
	background-image: url('<%=ORSView.APP_CONTEXT%>/img/course_img.jpg');
	background-size: cover;
	padding-top: 6%;
}
</style>

</head>
<body class="hm">
	<div class="header">
		<%@include file="Header.jsp"%>
		<%@include file="calendar.jsp"%>
	</div>
	<div>

		<main>
		<form action="<%=ORSView.INVENTORY_CTL%>" method="post">
			<jsp:useBean id="dto" class="in.co.rays.project_3.dto.InventoryDTO"
				scope="request"></jsp:useBean>
			<div class="row pt-3">
				<!-- Grid column -->
				<div class="col-md-4 mb-4"></div>
				<div class="col-md-4 mb-4">
					<div class="card input-group-addon">
						<div class="card-body">

							<%
								long id = DataUtility.getLong(request.getParameter("id"));

								if (dto.getId() != null && id > 0) {
							%>
							<h3 class="text-center default-text text-primary">Update
								Inventory</h3>
							<%
								} else {
							%>
							<h3 class="text-center default-text text-primary">Add
								Inventory</h3>
							<%
								}
							%>

							<div>
								<%
									Map map = (Map) request.getAttribute("imp");
								%>

								<H4 align="center">
									<%
										if (!ServletUtility.getSuccessMessage(request).equals("")) {
									%>
									<div class="alert alert-success alert-dismissible">
										<button type="button" class="close" data-dismiss="alert">&times;</button>
										<%=ServletUtility.getSuccessMessage(request)%>
									</div>
									<%
										}
									%>
								</H4>

								<H4 align="center">
									<%
										if (!ServletUtility.getErrorMessage(request).equals("")) {
									%>
									<div class="alert alert-danger alert-dismissible">
										<button type="button" class="close" data-dismiss="alert">&times;</button>
										<%=ServletUtility.getErrorMessage(request)%>
									</div>
									<%
										}
									%>

								</H4>

								<input type="hidden" name="id" value="<%=dto.getId()%>">

							</div>

							<div class="md-form">
								<span class="pl-sm-5"><b>Supplier Name</b> <span
									style="color: red;">*</span></span>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-user grey-text" style="font-size: 1rem;"></i>
											</div>
										</div>
										<input type="text" class="form-control" name="supplierName"
											placeholder=" Enter supplierName"
											oninput="handleLetterInput(this, 'supplierNameError', 20)"
											onblur="validateLetterInput(this, 'supplierNameError', 20)"
											value="<%=DataUtility.getStringData(dto.getSupplierName())%>">

									</div>

									<font color="red" class="pl-sm-5" id="supplierNameError">
										<%=ServletUtility.getErrorMessage("supplierName", request)%></font></br>
								</div>
								<span class="pl-sm-5"><b>Quantity</b> <span
									style="color: red;">*</span></span></br>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-list grey-text" style="font-size: 1rem;"></i>
											</div>
										</div>
										<input type="text" class="form-control" name="quantity"
											placeholder=" Enter quantity"
											oninput="handleIntegerInput(this, 'quantityError', 10)"
											onblur="validateIntegerInput(this, 'quantityError', 10)"
											value="<%=DataUtility.getStringData(dto.getQuantity()).equals("0") ? ""
					: DataUtility.getStringData(dto.getQuantity())%>">
									</div>

								</div>
								<font color="red" class="pl-sm-5" id="quantityError"><%=ServletUtility.getErrorMessage("quantity", request)%></font></br>

								<span class="pl-sm-5"><b>Product</b> <span
									style="color: red;">*</span></span>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-user grey-text" style="font-size: 1rem;"></i>
											</div>
										</div>
										<%-- <textarea type="text" class="form-control" name="colour"
											placeholder="Enter colour" id="colour"
											value="<%=DataUtility.getStringData(dto.getColour())%>"
											placeholder="Enter colour"
											oninput="handleLetterInput(this, 'colourError', 20)"
											onblur="validateLetterInput(this, 'colourError', 20)"></textarea>
									</div> --%>
										<%
											String htmlList = HTMLUtility.getList1("product", String.valueOf(dto.getProduct()), map);
										%>

										<%=htmlList%>
									</div>
								</div>
								<font color="red" class="pl-sm-5"> <%=ServletUtility.getErrorMessage("product", request)%></font></br>


								<span class="pl-sm-5"><b>LastUpdatedDate</b> <span
									style="color: red;">*</span></span>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-calendar grey-text" style="font-size: 1rem;"></i>
											</div>
										</div>
										<input type="text" id="datepicker" name="lastUpdatedDate"
											class="form-control" placeholder=" Enter lastUpdatedDate "
											readonly="readonly"
											value="<%=DataUtility.getDateString(dto.getLastUpdatedDate())%>">
									</div>
								</div>
								<font color="red" class="pl-sm-5"> <%=ServletUtility.getErrorMessage("lastUpdatedDate", request)%></font></br>
								<%
									if (dto.getId() != null && id > 0) {
								%>

								<div class="text-center">

									<input type="submit" name="operation"
										class="btn btn-success btn-md" style="font-size: 17px"
										value="<%=InventoryCtl.OP_UPDATE%>"> <input
										type="submit" name="operation" class="btn btn-warning btn-md"
										style="font-size: 17px" value="<%=InventoryCtl.OP_CANCEL%>">

								</div>
								<%
									} else {
								%>
								<div class="text-center">

									<input type="submit" name="operation"
										class="btn btn-success btn-md" style="font-size: 17px"
										value="<%=InventoryCtl.OP_SAVE%>"> <input
										type="submit" name="operation" class="btn btn-warning btn-md"
										style="font-size: 17px" value="<%=InventoryCtl.OP_RESET%>">
								</div>

							</div>
							<%
								}
							%>
						</div>
					</div>
		</form>
		</main>
		<div class="col-md-4 mb-4"></div>

	</div>

</body>
<%@include file="FooterView.jsp"%>

</body>
</html>