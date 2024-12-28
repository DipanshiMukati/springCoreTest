<%@page import="java.util.Map"%>
<%@page import="in.co.rays.project_3.dto.InventoryDTO"%>
<%@page import="in.co.rays.project_3.controller.InventoryListCtl"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="in.co.rays.project_3.model.ModelFactory"%>
<%@page import="in.co.rays.project_3.model.RoleModelInt"%>
<%@page import="in.co.rays.project_3.util.DataUtility"%>

<%@page import="in.co.rays.project_3.util.HTMLUtility"%>
<%@page import="in.co.rays.project_3.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Inventory List</title>
<script src="<%=ORSView.APP_CONTEXT%>/js/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=ORSView.APP_CONTEXT%>/js/CheckBox11.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="<%=ORSView.APP_CONTEXT%>/js/utility.js"></script>
<script>
	function validateNumberKey(event, validationMessageId) {
		// Allow only digits, minus sign, and dot for latitude and longitude input
		if (!/[0-9\.\-]/.test(event.key)) {
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
 <script>
        // Include the JavaScript function here or link to an external file
        function validateAlphaNum(inputElement, errorElementId, maxLength) {
            const errorMessage = document.getElementById(errorElementId);
            let currentValue = inputElement.value;

            // Clear existing error messages
            errorMessage.textContent = '';

            // Remove non-alphanumeric characters
            currentValue = currentValue.replace(/[^a-zA-Z0-9]/g, '');

            // Ensure the input starts with a letter if required
            if (currentValue.length > 0 && !/^[a-zA-Z]/.test(currentValue)) {
                errorMessage.textContent = 'Input must start with a letter.';
                currentValue = currentValue.replace(/^[^a-zA-Z]+/, ''); // Remove leading non-letters
            }

            // Ensure the length does not exceed maxLength
            if (currentValue.length > maxLength) {
                errorMessage.textContent = `Input exceeds the maximum length of ${maxLength} characters.`;
                currentValue = currentValue.slice(0, maxLength);
            }

            // Update the input field value
            inputElement.value = currentValue;
        }
    </script>



<style>
.hm {
	background-image: url('<%=ORSView.APP_CONTEXT%>/img/universe-1800259__480.webp');
	background-size: cover;
	background-repeat: no-repeate;
	padding-top: 6%;
}

.p1 {
	padding: 4px;
	width: 200px;
	font-size: bold;
}

.text {
	text-align: center;
}
</style>
</head>

<body class="hm">
	<%@include file="Header.jsp"%>
	<%@include file="calendar.jsp"%>
	<div></div>
	<div>
		<form class="pb-5" action="<%=ORSView.INVENTORY_LIST_CTL%>" method="post">
			<jsp:useBean id="dto" class="in.co.rays.project_3.dto.InventoryDTO"
				scope="request"></jsp:useBean>
			<%
			Map map = (Map) request.getAttribute("imp");
			%>


			<%
				int pageNo = ServletUtility.getPageNo(request);
				int pageSize = ServletUtility.getPageSize(request);
				int index = ((pageNo - 1) * pageSize) + 1;
				int nextPageSize = DataUtility.getInt(request.getAttribute("nextListSize").toString());
				RoleDTO rbean1 = new RoleDTO();
				RoleModelInt rmodel = ModelFactory.getInstance().getRoleModel();

				List list = ServletUtility.getList(request);

				Iterator<InventoryDTO> it = list.iterator();
				if (list.size() != 0) {
			%>
			<center>
				<h1 class="text-secondary font-weight-bold pt-3">Inventory List</h1>
			</center>
			<div class="row">
				<div class="col-md-4"></div>
				<%
					if (!ServletUtility.getSuccessMessage(request).equals("")) {
				%>

				<div class="col-md-4 alert alert-success alert-dismissible"
					style="background-color: #80ff80">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>
						<font color="#008000"><%=ServletUtility.getSuccessMessage(request)%></font>
					</h4>
				</div>
				<%
					}
				%>
				<div class="col-md-4"></div>
			</div>
			<div class="row">
				<div class="col-md-4"></div>

				<%
					if (!ServletUtility.getErrorMessage(request).equals("")) {
				%>
				<div class=" col-md-4 alert alert-danger alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<h4>
						<font color="red"> <%=ServletUtility.getErrorMessage(request)%></font>
					</h4>
				</div>
				<%
					}
				%>
				<div class="col-md-4"></div>
			</div>

			<div class="row">


				<div class="col-sm-2"></div>
				<div class="col-sm-2">


					<input type="text" name="supplierName" placeholder="Enter supplierName"
						class="form-control"
						oninput="validateAlphaNum(this, 'supplierNameError', 25)"
						onblur="validateAlphaNum(this, 'supplierNameError', 25)"
						value="<%=ServletUtility.getParameter("supplierName", request)%>">
					<font color="red" class="pl-sm-5" id="supplierNameError"></font>

				</div>


				<div class="col-sm-2">
					<input type="text" class="form-control" name="quantity"
						placeholder=" Enter quantity"
						oninput="handleIntergerInput(this, 'quantityError', 6)"
						onblur="validateIntergerInput(this, 'quantityError', 6)"
						oninput="numberLength(this)" step="any"
						value="<%=ServletUtility.getParameter("quantity", request)%>"
						onkeypress="validateNumberKey(event, 'quantity-validation-message')">
						<span id="quantity-validation-message"
									style="display: none; color: red;">Only number are
									allowed </span> <font color="red" class="pl-sm-5"
									id="quantityError"></font>
							</div>
				<div class="col-sm-2">


					<%-- <input type="text" name="colour"
						placeholder="Enter colour" class="form-control"
						oninput="handleLetterInput(this, 'colourError', 200)"
						onblur="validateLetterInput(this, 'colourError', 200)"
						value="<%=ServletUtility.getParameter("colour", request)%>">
									
					
					<font color="red" class="pl-sm-5" id="colourError"></font>--%>


					<%
						String htmlList = HTMLUtility.getList1("product", String.valueOf(dto.getProduct()), map);
					%>

					<%=htmlList%>
					 <font color="red" class="pl-sm-5"> <%=ServletUtility.getErrorMessage("product", request)%></font>
				</div>
				
				<div class="col-sm-2">
					<input type="text" name="lastUpdatedDate" placeholder="Enter lastUpdatedDate"
						id="datepicker" class="form-control"
						value="<%=ServletUtility.getParameter("lastUpdatedDate", request)%>">

					<font color="red" class="pl-sm-5"></font>
				</div>
				&emsp; <input type="submit" class="btn btn-primary btn-sm"
					style="font-size: 15px" name="operation"
					value="<%=InventoryListCtl.OP_SEARCH%>"> &emsp; <input
					type="submit" class="btn btn-dark btn-md" style="font-size: 15px"
					name="operation" value="<%=InventoryListCtl.OP_RESET%>">
			</div>

			<div class="col-sm-2"></div>
	</div>
	</div>
	</br>
	<div style="margin-bottom: 20px;" class="table-responsive">
		<table class="table table-bordered table-dark table-hover">
			<thead>
				<tr style="background-color: purple;">

					<th width="10%"><input type="checkbox" id="select_all"
						name="Select" class="text"> Select All</th>
					<th width="5%" class="text">S.NO</th>
					<th width="15%" class="text">Supplier Name</th>
					<th width="15%" class="text">Quantity</th>
					<th width="15%" class="text">Product</th>
					<th width="15%" class="text">Last Updated Date</th>

					<th width="10%" class="text">Edit</th>
				</tr>
			</thead>
			<%
				while (it.hasNext()) {
						dto = (InventoryDTO) it.next();
			%>
			<tbody>
				<tr>
					<td align="center"><input type="checkbox" class="checkbox"
						name="ids" value="<%=dto.getId()%>"></td>
					<td class="text"><%=index++%></td>
					<td class="text"><%=dto.getSupplierName()%></td>
					<td class="text"><%=dto.getQuantity()%></td>
      		<td class="text"><%= map.get(Integer.parseInt(dto.getProduct())) %></td>

					<td class="text"><%=DataUtility.getDateString(dto.getLastUpdatedDate())%></td>

					<td class="text"><a href="InventoryCtl?id=<%=dto.getId()%>">Edit</a></td>
				</tr>
			</tbody>
			<%
				}
			%>
		</table>
	</div>
	<table width="100%">
		<tr>
			<td><input type="submit" name="operation"
				class="btn btn-warning btn-md" style="font-size: 17px"
				value="<%=InventoryListCtl.OP_PREVIOUS%>"
				<%=pageNo > 1 ? "" : "disabled"%>></td>

			<td><input type="submit" name="operation"
				class="btn btn-primary btn-md" style="font-size: 17px"
				value="<%=InventoryListCtl.OP_NEW%>"></td>

			<td><input type="submit" name="operation"
				class="btn btn-danger btn-md" style="font-size: 17px"
				value="<%=InventoryListCtl.OP_DELETE%>"></td>

			<td align="right"><input type="submit" name="operation"
				class="btn btn-warning btn-md" style="font-size: 17px"
				style="padding: 5px;" value="<%=InventoryListCtl.OP_NEXT%>"
				<%=(nextPageSize != 0) ? "" : "disabled"%>></td>
		</tr>
		<tr></tr>
	</table>

	<%
		}
		if (list.size() == 0) {
	%>
	<center>
		<h1 style="font-size: 40px; color: #162390;">Inventory List</h1>
	</center>
	</br>
	<div class="row">
		<div class="col-md-4"></div>

		<%
			if (!ServletUtility.getErrorMessage(request).equals("")) {
		%>
		<div class=" col-md-4 alert alert-danger alert-dismissible">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<h4>
				<font color="red"> <%=ServletUtility.getErrorMessage(request)%></font>
			</h4>
		</div>
		<%
			}
		%>




		<%
			if (!ServletUtility.getSuccessMessage(request).equals("")) {
		%>

		<div class="col-md-4 alert alert-success alert-dismissible"
			style="background-color: #80ff80">
			<button type="button" class="close" data-dismiss="alert">&times;</button>
			<h4>
				<font color="#008000"><%=ServletUtility.getSuccessMessage(request)%></font>
			</h4>
		</div>
		<%
			}
		%>
		<div style="padding-left: 48%;">
			<input type="submit" name="operation" class="btn btn-primary btn-md"
				style="font-size: 17px" value="<%=InventoryListCtl.OP_BACK%>">
		</div>

		<div class="col-md-4"></div>
	</div>

	<%
		}
	%>

	<input type="hidden" name="pageNo" value="<%=pageNo%>">
	<input type="hidden" name="pageSize" value="<%=pageSize%>">
	</form>


	</div>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</br>
	</center>
	<%@include file="FooterView.jsp"%>
</body>

</html>