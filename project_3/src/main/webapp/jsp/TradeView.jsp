<%@page import="in.co.rays.project_3.controller.TradeCtl"%>
<%@page import="java.util.Map"%>

<%@page import="java.util.List"%>

<%@page import="java.util.HashMap"%>
<%@page import="in.co.rays.project_3.util.HTMLUtility"%>
<%@page import="in.co.rays.project_3.util.DataUtility"%>
<%@page import="in.co.rays.project_3.util.ServletUtility"%>
<%@page import="in.co.rays.project_3.controller.ORSView"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="<%=ORSView.APP_CONTEXT%>/js/validateInput.js"></script>
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Trade view</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="<%=ORSView.APP_CONTEXT%>/js/utilities.js"></script>

<script type="text/javascript">
	function validateMobileNo(event) {
		const input = event.target;
		input.value = input.value.replace(/[^0-9.]/g, '')
		if (input.value.length > 0 && input.value[0] <= '5') {
			input.value = '';
		}
	}
</script>


<style type="text/css">
i.css {
	border: 2px solid #8080803b;
	padding-left: 10px;
	padding-bottom: 11px;
	background-color: #ebebe0;
}

.input-group-addon {
	box-shadow: 9px 8px 7px #001a33;
	background-image: linear-gradient(to bottom right, purple, white);
	background-repeat: no repeat;
	background-size: 100%;
	padding-bottom: 11px;
}

.hm {
	background-image: url('<%=ORSView.APP_CONTEXT%>/img/download (3).jpeg');
	background-size: cover;
	padding-top: 6%;
}
</style>
<script>
	/**
	 * Function to validate input length (min 5, max 15 characters).
	 * @param {HTMLInputElement} input - The input field to validate.
	 * @param {string} errorElementId - The ID of the error message element.
	 */
	function validateLength(input, errorElementId) {
		const minLength = 5;
		const maxLength = 15;
		const value = input.value.trim();
		const errorElement = document.getElementById(errorElementId);

		// Check length validation
		if (value.length === 0) {
			errorElement.textContent = "UserId not less then 5 characture.";
			errorElement.textContent = "UserId not more then 15 characture.";

		} else if (value.length < minLength) {
			errorElement.textContent = `UserId must be at least ${minLength} characters.`;
		} else if (value.length > maxLength) {
			errorElement.textContent = `UserId must not exceed ${maxLength} characters.`;

		} else {
			errorElement.textContent = ""; // Clear error if valid
		}
	}
</script>


</head>
<body class="hm">
	<div class="header">
		<%@include file="Header.jsp"%>
		<%@include file="calendar.jsp"%>
	</div>
	<div>

		<main>
		<form action="<%=ORSView.TRADE_CTL%>" method="post">
			<jsp:useBean id="dto" class="in.co.rays.project_3.dto.TradeDTO"
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
								TradeList</h3>
							<%
								} else {
							%>
							<h3 class="text-center default-text text-primary">Add
								Trade</h3>
							<%
								}
							%>
							<!--Body-->
							<div>

								<%
									Map map = (Map) request.getAttribute("transactionTypeeee");
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

								<!-- ----------------------------------------------------------------------------------------------------------------------------------- -->
								<span class="pl-sm-5"><b> UserId</b> <span
									style="color: red;">*</span></span> </br>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-user-alt grey-text" style="font-size: 1rem;"></i>
											</div>
										</div>
										<input type="text" name="userId" placeholder="Enter UserId"
											class="form-control" 
											oninput="handleAlphanumericInput(this, 'userIdError', 15)"
											onblur="validateAlphanumericInput(this, 'userIdError', 15)"
											value="<%=DataUtility.getStringData(dto.getUserId())%>">


									</div>
								</div>


								<font color="red" class="pl-sm-5" id="userIdError"> <%=ServletUtility.getErrorMessage("userId", request)%></font></br>

								<!-- ----------------------------------------------------------------------------------------------------------------------------------- -->

								<span class="pl-sm-5"><b>StartDate</b> <span
									style="color: red;">*</span></span></br>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-calendar grey-text" style="font-size: 1rem;"></i>
											</div>
										</div>
										<input type="text" id="datepicker" name="startDate"
											class="form-control" placeholder="Date Of startDate"
											readonly="readonly"
											value="<%=DataUtility.getDateString(dto.getStartDate())%>">
									</div>
								</div>
								<font color="red" class="pl-sm-5"> <%=ServletUtility.getErrorMessage("startDate", request)%></font></br>


								<!-- ----------------------------------------------------------------------------------------------------------------------------------- -->

								<span class="pl-sm-5"><b>EndDate</b> <span
									style="color: red;">*</span></span></br>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-calendar grey-text" style="font-size: 1rem;"></i>
											</div>
										</div>
										<input type="text" id="datepicker1" name="endDate"
											class="form-control" placeholder="Date Of endDate"
											readonly="readonly"
											value="<%=DataUtility.getDateString(dto.getEndDate())%>">
									</div>
								</div>
								<font color="red" class="pl-sm-5"> <%=ServletUtility.getErrorMessage("endDate", request)%></font></br>
								<!-- ----------------------------------------------------------------------------------------------------------------------------------- -->




								<span class="pl-sm-5"><b>TransactionType</b> <span
									style="color: red;">*</span></span></br>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-user-circle grey-text"
													style="font-size: 1rem;"></i>
											</div>
										</div>


										<%=HTMLUtility.getList1("transactionType", String.valueOf(dto.getTransactionType()), map)%>

									</div>
								</div>
								<font color="red" class="pl-sm-5"> <%=ServletUtility.getErrorMessage("transactionType", request)%></font></br>





								<!-- ----------------------------------------------------------------------------------------------------------------------------------- -->



								<%-- 
								<%
								if (dto.getId()==null||id<=0) {
								%> --%>

								<%
									if (dto.getId() != null && id > 0) {
								%>

								<div class="text-center">

									<input type="submit" name="operation"
										class="btn btn-success btn-md" style="font-size: 17px"
										value="<%=TradeCtl.OP_UPDATE%>"> <input type="submit"
										name="operation" class="btn btn-warning btn-md"
										style="font-size: 17px" value="<%=TradeCtl.OP_CANCEL%>">

								</div>
								<%
									} else {
								%>
								<div class="text-center">

									<input type="submit" name="operation"
										class="btn btn-success btn-md" style="font-size: 17px"
										value="<%=TradeCtl.OP_SAVE%>"> <input type="submit"
										name="operation" class="btn btn-warning btn-md"
										style="font-size: 17px" value="<%=TradeCtl.OP_RESET%>">
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