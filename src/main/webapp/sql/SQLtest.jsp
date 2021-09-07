<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>


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


<script type="text/javascript" src="javascript.js"></script>

</head>
<body>

	<h1>H1</h1>

	<!-- Button to add new batch-->
	<button type="button" class="btn btn-primary" data-bs-toggle="modal"
		data-bs-target="#createBatch">Add new Student</button>

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
							<label for="StudentName" class="form-label">Student Name</label> <input
								type="text" class="form-control" id="StudentName"
								aria-describedby="emailHelp">
							<div id="emailHelp" class="form-text">Eg. Joshua Fernandes</div>
						</div>
						<div class="mb-3">
							<label for="Subject1" class="form-label">Subject 1</label> <input
								type="number" class="form-control" id="Subject1" min="1"
								step="1" data-bind="value:replyNumber" />
						</div>
						<div class="mb-3">
							<label for="Subject2" class="form-label">Subject 2</label> <input
								type="number" class="form-control" id="Subject2" min="1"
								step="1" data-bind="value:replyNumber" />
						</div>
						<div class="mb-3">
							<label for="Subject3" class="form-label">Subject 3</label> <input
								type="number" class="form-control" id="Subject3" min="1"
								step="1" data-bind="value:replyNumber" />
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal" data-bs-toggle="modal"
						data-bs-target="#addAssociate" onclick="createStudent();">Create Student</button>
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