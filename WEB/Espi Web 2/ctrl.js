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
        /*$scope.login = function(){
       
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
        	
        	
        };*/
        /*$scope.admin = function(){
        		window.location.href = "Admin/index.html";
        	};*/

        $scope.ingreso = function(){
        		if(($scope.email == "estudiante@gmail.com")&($scope.id == "1234")){
        			window.location.href = "Estudiante/index.html";
        		}
        		else{
        			alert("Su correo o su identificación son incorrectas");
        		}
        		//window.location.href = "Estudiante/index.html";
        	};

        /*$scope.cajero = function(){
        		localStorage.caja = prompt("Introduzca el número de caja", "0");
		        localStorage.monto = prompt("Introduzca el monto inicial", "0");
        		window.location.href = "Caja/Inicio/Inicio.html";
        	};*/
}]);
