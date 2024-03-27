<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Laravel</title>

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.bunny.net">
        <link href="https://fonts.bunny.net/css?family=figtree:400,600&display=swap" rel="stylesheet" />
        @vite(['resources/css/app.css', 'resources/js/app.js']) 
 <script
  src="https://code.jquery.com/jquery-3.7.1.min.js"
  integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
  crossorigin="anonymous"></script>  
        
        <style>
        </style>
    </head>
    <body class="antialiased">
        <h1>Test Tailwind</h1>
        <button id="btntest" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
  Button
</button>

<p class="zoomable">
        Click me to zoom
    </p>
   
    
        <h1>Test Jquery Ajax</h1>
      
        <h1>Test Ajax</h1>
  <button id="btnTestAjax" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
  Button
</button>
        <h1>Test Axios</h1>
        <button id="btnTestAxios" class="bg-orange-500 hover:bg-orange-700 text-white font-bold py-2 px-4 rounded">
  Button
</button>

        <div id="testResult">before click</div>



<script>
    $(document).ready(function(){

        $(".zoomable").on('click',function(){
                $(this).animate({
                    fontSize: "40px"
                }, 1000);
            });


        $("#btntest").on('click',function(){
            alert("ok");
        });

        $("#btnTestAjax").on('click',function(){
           
            $.ajax({
        url: '/test',
        success: function(data) {
            $("#testResult").html(data);
        }
    });
        });

    $("#btnTestAxios").on('click',function(){
      
        axios.get('/test')
        .then(response => {
                console.log(response)
                $("#testResult").html(response.data);
        })
        .catch(error => {
            console.log(error);
        });



        });
});
</script>
    </body>
</html>
