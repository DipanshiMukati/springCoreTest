package in.co.rays.project_3.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import in.co.rays.project_3.dto.BaseDTO;
import in.co.rays.project_3.dto.OrderDTO;
import in.co.rays.project_3.exception.ApplicationException;
import in.co.rays.project_3.exception.DuplicateRecordException;
import in.co.rays.project_3.model.ModelFactory;
import in.co.rays.project_3.model.OrderModelInt;
import in.co.rays.project_3.util.DataUtility;
import in.co.rays.project_3.util.DataValidator;
import in.co.rays.project_3.util.PropertyReader;
import in.co.rays.project_3.util.ServletUtility;


@WebServlet(name = "OrderCtl", urlPatterns = { "/ctl/OrderCtl" })
public class OrderCtl extends BaseCtl {
	
	
	@Override
	protected void preload(HttpServletRequest request) {

		Map<Integer, String> map = new HashMap();
		map.put(1, "leptop");
		map.put(2, "mobile");
		

		request.setAttribute("imp", map);
		System.out.println(map);

	}

	protected boolean validate(HttpServletRequest request) {
		boolean pass = true;

		if (DataValidator.isNull(request.getParameter("product"))) {
			request.setAttribute("product", PropertyReader.getValue("error.require", "product"));
			pass = false;
			/*
			 * } if (!DataValidator.isNamemaxlegntten(request.getParameter("supplierName")))
			 * { request.setAttribute("supplierName", "name should be 20 characters"); pass
			 * = false;
			 */

		}  

		if (DataValidator.isNull(request.getParameter("quantity"))) {
			request.setAttribute("quantity", PropertyReader.getValue("error.require", "quantity"));
			pass = false;
		}
			/*
			if (!DataValidator.isInteger(request.getParameter("quantity"))) {
				request.setAttribute("quantity", " must contains number only ");
			
			pass = false;*/
		
	

		//and No. Series start with 6-9

		if (!OP_UPDATE.equalsIgnoreCase(request.getParameter("operation"))) {

			if (DataValidator.isNull(request.getParameter("customer"))) {
				request.setAttribute("customer", PropertyReader.getValue("error.require", "customer"));
				pass = false;
			}

			if (DataValidator.isNull(request.getParameter("date"))) {
				request.setAttribute("date", PropertyReader.getValue("error.require", "date"));
				pass = false;

			}

		}
		return pass;
	}

	protected BaseDTO populateDTO(HttpServletRequest request) {
		OrderDTO dto = new OrderDTO();

		System.out.println(request.getParameter("date"));

		dto.setId(DataUtility.getLong(request.getParameter("id")));
		dto.setProduct(DataUtility.getString(request.getParameter("product")));
		dto.setQuantity(DataUtility.getInt(request.getParameter("quantity")));
		dto.setDate(DataUtility.getDate(request.getParameter("date")));
		dto.setCustomer(DataUtility.getString(request.getParameter("customer")));

		populateBean(dto, request);

		return dto;

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String op = DataUtility.getString(request.getParameter("operation"));
		OrderModelInt model = ModelFactory.getInstance().getOrderModel();
		long id = DataUtility.getLong(request.getParameter("id"));
		if (id > 0 || op != null) {
			OrderDTO dto;
			try {
				dto = model.findByPK(id);
				ServletUtility.setDto(dto, request);
			} catch (Exception e) {
				e.printStackTrace();
				ServletUtility.handleException(e, request, response);
				return;
			}
		}
		ServletUtility.forward(getView(), request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String op = DataUtility.getString(request.getParameter("operation"));
		OrderModelInt model = ModelFactory.getInstance().getOrderModel();
		long id = DataUtility.getLong(request.getParameter("id"));
		if (OP_SAVE.equalsIgnoreCase(op) || OP_UPDATE.equalsIgnoreCase(op)) {
			OrderDTO dto = (OrderDTO) populateDTO(request);
			System.out.println("nooooooooooooooooooooooooooooooooooooooooooooooo");
			try {
				System.out.println("adddddddddddddddddddddddddddddddddddddddddddddddddddd");
				if (id > 0) {
					model.update(dto);

					ServletUtility.setSuccessMessage("Data is successfully Update", request);
				} else {

					try {
						model.add(dto);

						ServletUtility.setDto(dto, request);
						ServletUtility.setSuccessMessage("Data is successfully saved", request);
					} catch (ApplicationException e) {
						ServletUtility.handleException(e, request, response);
						return;
					} catch (DuplicateRecordException e) {
						ServletUtility.setDto(dto, request);
						ServletUtility.setErrorMessage("Login id already exists", request);
					}

				}
				ServletUtility.setDto(dto, request);

			} catch (ApplicationException e) {
				ServletUtility.handleException(e, request, response);
				return;
			} catch (DuplicateRecordException e) {
				ServletUtility.setDto(dto, request);
				ServletUtility.setErrorMessage("Login id already exists", request);
			}
		} else if (OP_DELETE.equalsIgnoreCase(op)) {

			OrderDTO dto = (OrderDTO) populateDTO(request);
			try {
				model.delete(dto);
				ServletUtility.redirect(ORSView.ORDER_LIST_CTL, request, response);
				return;
			} catch (ApplicationException e) {
				ServletUtility.handleException(e, request, response);
				return;
			}

		} else if (OP_CANCEL.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.ORDER_LIST_CTL, request, response);
			return;
		} else if (OP_RESET.equalsIgnoreCase(op)) {

			ServletUtility.redirect(ORSView.ORDER_CTL, request, response);
			return;
		}
		ServletUtility.forward(getView(), request, response);

	}

	@Override
	protected String getView() {
		// TODO Auto-generated method stub
		return ORSView.ORDER_VIEW;
	}

}