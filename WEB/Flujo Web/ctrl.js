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
        $scope.login = function(){
       
        	var data = {cedula: user = parseInt($scope.user, 10),
				pass: $scope.pass};
			console.log($scope.user);
				$http.post("http://webapi220171117104514.azurewebsites.net/api/empleado?codigo=1", data).
        		then(function(response) {
            		$scope.greet = response.data;
            		console.log(response.data);
            		var res = JSON.stringify($scope.greet);
	        				localStorage.compania = $scope.greet.idcompania;
	        				localStorage.nombreCompania = $scope.greet.compania;
	        				localStorage.perfil = res;
            		if($scope.greet.codigo == 200){
	        			if($scope.greet.tipo == 1){
	        				
	        				console.log(res);
							window.location.href = "Admin/index.html";
		        			}
		        		if($scope.greet.tipo == 2){
		        			localStorage.caja = prompt("Introduzca el número de caja", "0");
		        			localStorage.monto = prompt("Introduzca el monto inicial", "0");
		        			console.log(localStorage.caja);
		        			console.log(localStorage.monto);
		        			var res = JSON.stringify($scope.data);
							window.location.href = "Caja/Inicio/Inicio.html";
		        		}
		        		if($scope.greet.tipo == 3){
		        			var res = JSON.stringify($scope.data);
							window.location.href = "#!decidir";
		        		}
		        		else{
		        			alert("Usted no puede accesar al sistema");
		        		}


        		
        	}
        		});
        	
        	
        };

        $scope.ingreso = function(){
        	if(document.getElementById("est").checked){
        		var data = {
						  "carne": $scope.email,
						  "email": $scope.id,
						};
        		$http.post("http://localhost:7878/ce/StudentAuth/Token", data).
        		then(function(response) {
            		$scope.greet = response.data;
            		console.log(response.data);
        		});
        		if($scope.greet.Message != undefined){
        			var pass = prompt($scope.greet);
        			if(pass!=null){
        				var data = {
									  "carne": $scope.id,
									  "email": $scope.email,
									  "token": pass
									}
        				$http.post("http://localhost:7878/ce/StudentAuth/Authenticate", data).
		        		then(function(response) {
		            		$scope.greet = response.data;
		            		console.log(response.data);
		            		var res = JSON.stringify($scope.greet);
	        				localStorage.perfil = res;
	        				window.localtion.href = "Estudiante/index.html";
		        		});
        			}
        			else{
        				alert("Fallo en la identificación");
        			}
        		}
        		else{
        			alert($scope.greet.Message);
        		}
        	}
        	else{
        		var data = {
						  "carne": $scope.email,
						  "email": btoa($scope.id),
						};
        		$http.post("http://localhost:7878/ce/UserAuth/Authenticate", data).
        		then(function(response) {
            		$scope.greet = response.data;
            		console.log(response.data);
            		var res = JSON.stringify($scope.greet.usuario);
	        		localStorage.perfil = res;
        		});
        		if($scope.greet.Message != undefined){
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
			        	if($scope.greet.usuario.rols[0]==2){
		        			window.localtion.href = "Administrativo/index.html";
		        		}
        			}
        			else{
        				if($scope.greet.usuario.rols[0]==2){
		        			window.localtion.href = "Administrativo/index.html";
		        		}
        			}
        		}
        		else{
        			alert($scope.greet.Message);
        		}

        	}

        	};
}]);
