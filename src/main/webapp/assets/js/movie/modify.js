
$(function(){
    edit_mode = 'edit';
    $("#genre_info").val(genre_no).prop("selected",true);
    $("#viewing_age").val(viewing_age).prop("selected",true);
    $("#movie_status").val(movie_status).prop("selected",true);

    console.log(movie_imgs);
    console.log(movie_desc_list);
    console.log(movie_trailer_list);

    $("input, button, textarea, select").prop("disabled", true);
    $("#edit").prop("disabled", false);
    $("#edit").click(function(){
        $("input, button, textarea, select").prop("disabled", false);

    });
})