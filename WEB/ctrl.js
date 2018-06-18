var app = angular.module("computer", ["ngRoute"])

.config(["$routeProvider", function($routeProvider){
	$routeProvider.
		when("/",{
			templateUrl: "login1.html",
			controller: "LogCtrl"
			//css = "stylesss.css"
		}).
		otherwise({
			redirectTo: "/"
		});
	}])

.controller("LogCtrl",["$scope", "$http",function($scope, $http, $location, MyService){
		$scope.greet = {};

        $scope.ingreso = function(){
        	if(document.getElementById("est").checked){
        		var data = {
						  "carne": $scope.ident,
						  "email": $scope.email,
						};
        		$http.post("http://localhost:7878/ce/StudentAuth/Token", data).
        		then(function(response) {
            		$scope.greet = response.data;
            		console.log(response.data);
        		});
        		setTimeout(function(){
        			if($scope.greet.Message == undefined){
        				console.log("Entra al if")
	        			var pass = prompt("Ingrese el token enviado a su correo");
	        			if(pass!=null){
	        				var data = {
										  "carne": $scope.ident,
										  "email": $scope.email,
										  "token": pass
										}
	        				$http.post("http://localhost:7878/ce/StudentAuth/Authenticate", data).
			        		then(function(response) {
			            		$scope.greet = response.data;
			            		console.log(response.data);
			            		var res = JSON.stringify($scope.greet);
		        				localStorage.perfil = res;
		        				window.location.href = "Estudiante/index.html";
			        		});
	        			}
	        			else{
	        				alert("Fallo en la identificación");
	        			}
	        		}
	        		else{
	        			alert($scope.greet.Message);
	        		}
        		}, 500);
        		
        	}
        	else{
        		var data = {
						  "password": btoa($scope.ident),
						  "correo_electronico": $scope.email,
						};
        		$http.post("http://localhost:7878/ce/UserAuth/Authenticate", data).
        		then(function(response) {
            		$scope.greet = response.data;
            		console.log(response.data);
            		var res = JSON.stringify($scope.greet.usuario);
	        		localStorage.perfil = res;
        		});
        		setTimeout(function(){
        			console.log($scope.greet);
        			if($scope.greet.Message == undefined){
	        			if($scope.greet.first_time){
	        				var newPass = prompt("Ingrese una nueva contraseña");
	        				var data = {
										  "correo_electronico": $scope.greet.usuario.correo_electronico,
										  "contrasenna": btoa(newPass),
										  "cedula": $scope.greet.usuario.cedula,
										  "primer_nombre": $scope.greet.usuario.primer_nombre,
										  "segundo_nombre": $scope.greet.usuario.segundo_nombre,
										  "primer_apellido": $scope.greet.usuario.primer_apellido,
										  "segundo_apellido": $scope.greet.usuario.segundo_apellido
										}
	        				
	        				$http.put("http://localhost:7878/ce/Users/8", Data).
				        	then(function(response) {
				            	$scope.greet2 = response.data;
				            	console.log($scope.greet2);
				        	});
				        	if($scope.greet.usuario.rols[0].id_rol==2){
			        			window.location.href = "Administrativo/index.html";
			        		}
	        			}
	        			else{
	        				console.log("Caso");
	        				console.log($scope.greet.usuario.rols);
	        				if($scope.greet.usuario.rols[0].id_rol==2){
			        			window.location.href = "Administrativo/index.html";
			        		}
	        			}
	        		}
	        		else{
	        			alert($scope.greet.Message);
	        		}
        		}, 500);
        		

        	}

        	};
}]);
