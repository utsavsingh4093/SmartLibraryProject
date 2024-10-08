<%@page import="java.time.LocalDate"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Renew Books here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
</head>
<body>
	<%
	String message = (String) session.getAttribute("message");
	if (message != null) {
	%>
	<div class="alert alert-success alert-dismissible">
		<a href="RenewBook.jsp" class="close" data-dismiss="alert"
			aria-label="close">&times;</a> <strong><%=message%>!</strong>
	</div>
	<%
	session.removeAttribute("message");
	}
	%>

	<%
	String mess = (String) session.getAttribute("mess");
	if (mess != null) {
	%>
	<div class="alert alert-danger alert-dismissible">
		<a href="RenewBook.jsp" class="close" data-dismiss="alert"
			aria-label="close">&times;</a> <strong><%=mess%>!</strong>
	</div>
	<%
	session.removeAttribute("mess");
	}
	%>

	<%
	String messe = (String) session.getAttribute("messages");
	if (messe != null) {
	%>
	<div class="alert alert-danger alert-dismissible">
		<a href="RenewBook.jsp" class="close" data-dismiss="alert"
			aria-label="close">&times;</a> <strong><%=messe%>!</strong>
	</div>
	<%
	session.removeAttribute("messages");
	}
	%>
	<c:set value="${getingreturndate}" var="a"></c:set>
	<h1 style="text-align: center; color: blue;">This Renew Books
		Detail</h1>
	<a href="UserHome.jsp"><button
			style="margin-left: 30px; border-radius: 50px;" type="submit"
			class="btn btn-danger">Go Back</button></a>
	<sql:setDataSource driver="com.mysql.cj.jdbc.Driver" var="ds"
		url="jdbc:mysql://localhost:3306/library_project" user="root"
		password="4093" />
	<sql:query dataSource="${ds}" var="rs">select * from issueBooks where sid='<c:out
			value="${getsId}" />' and userbooks>0 and status='Issued';</sql:query>

	<div class="container">
		<table class="table">
			<tr>
				<td>Image</td>
				<td>Book Name</td>
				<td>Author Name</td>
				<td>Edition</td>
				<td>Books Quantity</td>
				<td>Issue Date</td>
				<td>Return Date</td>
				<td>Issue</td>
			</tr>

			<tbody id="myTable">
				<c:forEach items="${rs.rows}" var="row">
					<tr>
						<td><c:url var="imageUrl" value="/Book/${row.bookimg}" /> <img
							src="${imageUrl}" alt="Book Image" style="max-width: 50px;" /></td>
						<td><c:out value="${row.BookName}"></c:out></td>
						<td><c:out value="${row.Authorname}"></c:out></td>
						<td><c:out value="${row.Edition}" /></td>
						<td><c:out value="${row.userbooks}" /></td>

						<form action="newbooks" method="post">
							<td><input type="date" name="issuedate"
								value='<c:out value="${row.issuedate}"></c:out>'></td>
							<td><input type="date" name="returndate"
								value='<c:out value="${row.returndate}"></c:out>'></td>
							<td><input type="hidden" name="id" value="${row.id}" />
							<input type="hidden" name="bookid" value="${row.bookid}" />
								<button type="submit" class="btn btn-success">Renew</button>
						</form>
					</tr>
				</c:forEach>
			<tbody>
		</table>
	</div>
</body>
</html>