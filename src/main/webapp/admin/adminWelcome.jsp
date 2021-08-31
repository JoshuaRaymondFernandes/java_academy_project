<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


<script>
	function createBatch() {

		var batchName = document.getElementById('batchName').value;
		var batchSize = document.getElementById('batchSize').value;

		$.ajax({
			type : 'POST',
			url : '/training_platform/createBatch',
			data : 'batchName=' + batchName + '&batchSize=' + batchSize,
			error : function(response) {
				// Gets called when an error occurs with error details in variable response
				console.log("Error while calling createBatch");
			},
			success : function(response) {
				// Gets called when the action is successful with server response in variable response
				console.log("Successfully created new batch");
			}
		});
	}

	function onLoad() {

		console.log("this runs");

		$.ajax({
			type : 'GET',
			url : '/training_platform/FetchBatches',
			error : function(request, status, error) {
				// Gets called when an error occurs with error details in variable response
				console.log(status);
			},
			success : function(response) {
				// Gets called when the action is successful with server response in variable response
				console.log(response);

				var returnedData = JSON.parse(response.data);
				var $tableRef = $('<table class="table table-bordered">')

				$.each(returnedData, function(i, item) {
					var $tr = $('<tr>').append(
							$('<td class="text-center">').text(item.ID),
							$('<td class="text-center">').text(item.batchName),
							$('<td class="text-center">').text(item.batchSize)
							); //.appendTo('#records_table');
							$tableRef.append($tr);
				});
				$("#records_table").html($tableRef)
			}
		});

		$('#tab').append(
				$('<tr>').append($('<td>').append("text1")).append(
						$('<td>').append("text2")).append(
						$('<td>').append("text3")).append(
						$('<td>').append("text4")))
	}
</script>
</head>
<body>

	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");

	if (session.getAttribute("username") == null) {
		response.sendRedirect("/training_platform/login.jsp");
	}
	%>
	<div class="float-end">
		<form action="/training_platform/logout">
			<input type="submit" value="Logout">
		</form>
	</div>
	<br>

	<h1>Admin JSP</h1>
	<h2>Welcome ${username}</h2>



	<!-- Button to add new batch-->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#createBatch">Add new batch</button>

	<!-- Modal -->
	<div class="modal fade" id="createBatch" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form name="createNewBatch" onsubmit="return false">
						<div class="mb-3">
							<label for="batchName" class="form-label">Batch Name</label> <input
								type="text" class="form-control" id="batchName"
								aria-describedby="emailHelp">
							<div id="emailHelp" class="form-text">Eg. Batch 2A</div>
						</div>
						<div class="mb-3">
							<label for="batchSize" class="form-label">Batch Size</label> <input
								type="number" class="form-control" id="batchSize" min="1"
								step="1" data-bind="value:replyNumber" />
						</div>

						<button type="submit" class="btn btn-primary"
							onclick="createBatch();">Create Batch</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal" data-bs-toggle="modal"
						data-bs-target="#addStudents">Add New Student</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Button to view batches-->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#showBatches" onclick="onLoad();">View batches</button>


	<!-- Modal -->
	<div class="modal fade" id="showBatches" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Existing
						Batches</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<table id="records_table" class="table table-bordered">
						<thead>
							<tr>
								<th scope="col" class="text-center">Batch No</th>
								<th scope="col" class="text-center">Batch Name</th>
								<th scope="col" class="text-center">Batch Size</th>
							</tr>
						</thead>

					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal" data-bs-toggle="modal"
						data-bs-target="#createBatch">Add New Batch</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Button to add new batch-->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#addStudents">Add new student</button>


	<!-- Modal -->
	<div class="modal fade" id="addStudents" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form>
						<div class="mb-3">
							<label for="studentName" class="form-label">Student Name</label>
							<input type="text" class="form-control" id="studentName"
								aria-describedby="emailHelp">
							<div id="emailHelp" class="form-text">Eg. Batch 2A</div>
						</div>
						<div class="mb-3">
							<label for="studentID" class="form-label">Student ID</label> <input
								type="number" class="form-control" id="studentID" min="1"
								step="1" data-bind="value:replyNumber" />
						</div>

						<button type="submit" class="btn btn-primary">Create New
							Student</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>
	</div>

	<table id="tab">
		<tr>
			<th>Firstname</th>
			<th>Lastname</th>
			<th>Age</th>
			<th>City</th>
		</tr>
		<tr>
			<td>Jill</td>
			<td>Smith</td>
			<td>50</td>
			<td>New York</td>
		</tr>
	</table>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
		integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
		integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF"
		crossorigin="anonymous"></script>

</body>
</html>