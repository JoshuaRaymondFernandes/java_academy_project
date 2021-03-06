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


<script  type= "text/javascript">
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
	
	function createSubject() {
		var subjectName = document.getElementById('subjectName').value;
		var hoursLength = document.getElementById('hoursLength').value;

		$.ajax({
			type : 'POST',
			url : '/training_platform/CreateSubject',
			data : 'subjectName=' + subjectName + '&hoursLength=' + hoursLength,
			error : function(response) {
				// Gets called when an error occurs with error details in variable response
				console.log("Error while calling CreateSubject");
			},
			success : function(response) {
				// Gets called when the action is successful with server response in variable response
				console.log("Successfully created new subject");
			}
		});
	}

	function createAssociate() {

		var studentID = document.getElementById('studentID').value;
		var studentName = document.getElementById('studentName').value;
		var batchSelection = document.getElementById('batchSelection').value;

		$.ajax({
			type : 'POST',
			url : '/training_platform/CreateAssociate',
			data : 'studentID=' + studentID + '&studentName=' + studentName
					+ '&batchSelection=' + batchSelection,
			error : function(response) {
				// Gets called when an error occurs with error details in variable response
				console.log("Error while creating new students");
			},
			success : function(response) {
				// Gets called when the action is successful with server response in variable response
				console.log("Successfully created new associate");
				$("#createNewStudentForm")[0].reset();
				document.getElementById('studentID').value = '';
				document.getElementById('studentName').value = '';
			}
		});
	}

	function fetchBatches() {

		console.log("Fetching Batches from FetchBatches");

		$.ajax({
			type : 'GET',
			url : '/training_platform/FetchBatches',
			error : function(request, status, error) {
				// Gets called when an error occurs with error details in variable response
				console.log(error);
			},
			success : function(response) {
				// Gets called when the action is successful with server response in variable response

				updateViewBatches(response.data);
				updateSelectBatches(response.data);
			}
		});
	}
	
	function deleteBatch() {
	
		console.log("Delete Batch from FetchBatches");
		
		var batchId = document.getElementById('batchDeletion').value;

		$.ajax({
			type : 'POST',
			url : '/training_platform/DeleteBatch',
			data : 'batchId=' + batchId,
			error : function(request, status, error) {
				// Gets called when an error occurs with error details in variable response
				console.log(error);
			},
			success : function(response) {
				// Gets called when the action is successful with server response in variable response

				console.log("Successfully deleted batch and its associates");
			}
		});
	}
	
	function fetchAssociates() {

		console.log("Fetching Associates from FetchAssociates");

		$.ajax({
			type : 'GET',
			url : '/training_platform/FetchAssociates',
			error : function(request, status, error) {
				// Gets called when an error occurs with error details in variable response
				console.log(error);
			},
			success : function(response) {
				// Gets called when the action is successful with server response in variable response

				updateViewAssociates(response.data);
			}
		});
	}
	
	function updateViewAssociates(response) {

		var returnedData = JSON.parse(response);
		var $tableRef = $('<table class="table table-bordered">')

		// Adding the headers

		var $th = $('<tr>').append($('<th class="text-center">').text("Associate ID"),
				$('<th class="text-center">').text("Name"),
				$('<th class="text-center">').text("Batch Name"));
		$tableRef.append($th);

		$.each(returnedData, function(i, item) {
			var $tr = $('<tr>').append(
					$('<td class="text-center">').text(item.studentID),
					$('<td class="text-center">').text(item.studentName),
					$('<td class="text-center">').text(item.batchName)); //.appendTo('#records_table');
			$tableRef.append($tr);
		});
		$("#associates_table").html($tableRef)

	}

	function updateSelectBatches(response) {
		var returnedData = JSON.parse(response);

		var $optionSelection = $('<select id="batchSelection" class="form-select" aria-label="Default select example">');
		var $optionDeletion = $('<select id="batchDeletion" class="form-select" aria-label="Default select example">');

		$.each(returnedData, function(i, item) {
			$optionSelection.append($('<option>', {
				value : item.ID,
				text : item.batchName
			}));
			$optionDeletion.append($('<option>', {
				value : item.ID,
				text : item.batchName
			}));
		});
		$('#batchSelectionSection').html($optionSelection)
		$("#batchDeletionSection").html($optionDeletion)
	}

	function updateViewBatches(response) {

		var returnedData = JSON.parse(response);
		var $tableRef = $('<table class="table table-bordered">')

		// Adding the headers

		var $th = $('<tr>').append($('<th class="text-center">').text("ID"),
				$('<th class="text-center">').text("Batch Name"),
				$('<th class="text-center">').text("Batch Size"));
		$tableRef.append($th);

		$.each(returnedData, function(i, item) {
			var $tr = $('<tr>').append(
					$('<td class="text-center">').text(item.ID),
					$('<td class="text-center">').text(item.batchName),
					$('<td class="text-center">').text(item.batchSize)); //.appendTo('#records_table');
			$tableRef.append($tr);
		});
		$("#records_table").html($tableRef)

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
						data-bs-target="#addAssociate">Add New Associate</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Button to view batches-->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#showBatches" onclick="fetchBatches();">View
		batches</button>


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


	<!-- Button to add new Associate-->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#addAssociate" onclick="fetchBatches();">Add
		new Associate</button>


	<!-- Modal -->
	<div class="modal fade" id="addAssociate" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form name="createNewStudentForm" onsubmit="return false">
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
						<div class="mb-3">
							<label for="batchSelectionSection" class="form-label">Select
								Batch :</label>
							<div id="batchSelectionSection">
								<select class="form-select" aria-label="Default select example">
									<option value="NA">Not Assigned</option>

								</select>
							</div>
						</div>

						<button type="submit" class="btn btn-primary"
							onclick="createAssociate();">Create New Associate</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal" data-bs-toggle="modal"
						data-bs-target="#addAssociate">Add Another New Associate</button>
				</div>
			</div>
		</div>
	</div>


	<!-- Button to view batches-->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#showAssociates" onclick="fetchAssociates();">View
		Associates</button>


	<!-- Modal -->
	<div class="modal fade" id="showAssociates" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Existing
						Associates</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<table id="associates_table" class="table table-bordered">
						<thead>
							<tr>
								<th scope="col" class="text-center">Associate ID</th>
								<th scope="col" class="text-center">Name</th>
								<th scope="col" class="text-center">Batch Name</th>
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
	
	<!-- Button to view batches-->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#deleteBatch" onclick="fetchBatches();">Delete Batch</button>


	<!-- Modal -->
	<div class="modal fade" id="deleteBatch" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Delete Batch</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form name="deleteBatchForm" onsubmit="return false">
						
						<div class="mb-3">
							<label for="batchSelectionSection" class="form-label">
							Select which Batch you would like to delete :</label>
							<div id="batchDeletionSection">
								<select class="form-select" aria-label="Default select example">
									<option value="NA">Not Assigned</option>
								</select>
							</div>
						</div>

						<button type="submit" class="btn btn-danger"
							onclick="deleteBatch();">Delete Batch</button>
					</form>
					
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
		data-bs-target="#createSubject">Add new Subject</button>

	<!-- Modal -->
	<div class="modal fade" id="createSubject" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Add New Subject</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form name="createNewSubject" onsubmit="return false">
						<div class="mb-3">
							<label for="subjectName" class="form-label">Subject Name :</label> <input
								type="text" class="form-control" id="subjectName"
								aria-describedby="emailHelp">
							<div id="emailHelp" class="form-text">Eg. SQL</div>
						</div>
						<div class="mb-3">
							<label for="hoursLength" class="form-label">Number of Hours :</label> <input
								type="number" class="form-control" id="hoursLength" min="1"
								step="1" data-bind="value:replyNumber" />
						</div>

						<button type="submit" class="btn btn-primary"
							onclick="createSubject();">Create Subject</button>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal" data-bs-toggle="modal"
						data-bs-target="#createSubject">Add Another Subject</button>
				</div>
			</div>
		</div>
	</div>

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