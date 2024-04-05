<!DOCTYPE html>
<html @if(app()->getLocale() == 'ar') dir="rtl" @endif 
    lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   
    <title>Laravel 10 CRUD Application - ItSolutionStuff.com</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    @vite(['resources/css/app.css', 'resources/js/app.js']) 
    <script
  src="https://code.jquery.com/jquery-3.7.1.min.js"
  integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
  crossorigin="anonymous"></script> 

</head>
<body>
 <div>

    <select name="selectLocale" id="selectLocale">
        <option @if(app()->getLocale() == 'ar') selected @endif value="ar">ar</option>
        <option @if(app()->getLocale() == 'fr') selected @endif value="fr">fr</option>
        <option @if(app()->getLocale() == 'en') selected @endif value="en">en</option>
        <option @if(app()->getLocale() == 'es') selected @endif value="es">es</option>
    </select>
 </div>   
<div class="container">
    @yield('content')
</div>

<script>

    $("#selectLocale").on('change',function(){
        var locale = $(this).val();
      
        window.location.href = "/changeLocale/"+locale;
    })
</script>
    @yield('scripts')
</body>
</html>