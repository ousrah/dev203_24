<div id="myModal" class="modal">

  <!-- Modal content -->
  <div class="modal-content">
    <div class="modal-header">
      <span id = "close" class="close">&times;</span>
      <h2>Delete</h2>
    </div>
    <div class="modal-body">
        <form id="deleteForm" method="post">
            @csrf
            <input type="text" id="deleteId" name="deleteId" value="" />
        </form>
      <p>Are you sure te delete this product?</p>
   
    </div>
    <div class="modal-footer">
      <button id = "btnDelete" class="btn bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded" id="btnDelete">Delete</button>
      <button id = "btnCancel" class="btn bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded" id="close">Cancel</button>
    </div>
  </div>

</div>
<script>
     $("#close").on('click',function(){
        $("#myModal").hide();
    })
    $("#btnCancel").on('click',function(){
        $("#myModal").hide();
    })
    $("#btnDelete").on('click',function(){
        var formData = $('#deleteForm').serialize(); // Serialize form data
        axios.post('{{ route("products.delete") }}', formData)
            .then(function (response) {
               if(response.data=="ok")
               {
                $("#row"+$("#deleteId").val()).remove();
               }
            })
            .catch(function (error) {
                console.error(error);
            });

        $("#myModal").hide();
    });
    $
    </script>