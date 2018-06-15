var app = angular.module("computer", ["ngRoute"])

.config(["$routeProvider", function($routeProvider){
	$routeProvider.
		when("/",{
			templateUrl: "perfil.html",
			controller: "StudentCtrl"
		}).
		when("/hAsist",{
			templateUrl: "Asistencia.html",
			controller: "StudentCtrl"
		}).
		when("/hTutor",{
			templateUrl: "Tutorias.html",
			controller: "StudentCtrl"
		}).
		when("/hEst",{
			templateUrl: "horasEstudiante.html",
			controller: "StudentCtrl"
		}).
		when("/asistEsp",{
			templateUrl: "aEspecial.html",
			controller: "StudentCtrl"
		}).
		when("/historial",{
			templateUrl: "historial.html",
			controller: "StudentCtrl"
		}).
		when("/borradores",{
			templateUrl: "borradores.html",
			controller: "StudentCtrl"
		}).
		when("/borrador",{
			templateUrl: "borrador.html",
			controller: "StudentCtrl"
		}).
		otherwise({
			redirectTo: "/"
		});
	}])

.controller("StudentCtrl",["$scope", "$http",function($scope, $http, $location, MyService){

		$scope.solicitudes = [{"ID":115, "Fecha de Solicitud":"04/02", "Hora de Solicitud":"11:14AM", "Estado":"Pendiente"},{"ID":191, "Fecha de Solicitud":"05/02", "Hora de Solicitud":"08:52AM", "Estado":"Pendiente"}];

        $scope.hTutor = function(){
        		window.location.href = "#!hTutor";
        	};

        $scope.hAsist = function(){
        		window.location.href = "#!hAsist";
        	};
        $scope.hEst = function(){
        		window.location.href = "#!hEst";
        	};
        $scope.asistEsp = function(){
        		window.location.href = "#!asistEsp";
        	};
        $scope.enviar = function(){
        		if (window.File && window.FileReader && window.FileList && window.Blob) {
        			alert('Todo ak7');
				  // Great success! All the File APIs are supported.
				} else {
				  alert('The File APIs are not fully supported in this browser.');
				}
        		alert("Su solicitud ha sido enviada");
        	};
        $scope.guardar = function(){
        		alert("Su solicitud ha sido guardada");
        	};
        $scope.cancelar = function(){
        		confirm("¿Desea cancelar la solicitud seleccionada?")
        		alert("La cancelación de su solicitud ha sido solicitada");
        	};
        $scope.abrirBorrador = function(){
        		window.location.href = "#!borrador"
        	};
        $scope.atras = function(){
        		window.location.href = "#!borradores"
        	};

}]);
