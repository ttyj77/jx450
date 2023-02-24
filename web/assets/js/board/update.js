initPage = (id) => {
    let temp = new URLSearchParams(window.location.search).get('id');

    let data;

    data = {'id': temp}
    $.ajax({
        url: "/board/printOne",
        method: "get",
        data: data,
        success: (message) => {
            console.log(message);
            let result = JSON.parse(message);
            console.log(result)
            if (result.status == "success") {
                let data = JSON.parse(result.data);
                console.log("success")
                console.log(data)
                printData(data);
            } else if (result.status == "fail") {
                Swal.fire({title: "!!!!에러다!!!", text: result.message, icon: "error"}).then(() => {

                    location.href = result.nextPath;
                })
            }
        }

    });
}

function printData(data) {
    $('#input-id').val(data.id + "번");
    $('#input-title').val(data.title);
    $('#editor').text(data.content);

    ClassicEditor.create(document.querySelector('#editor')).catch(error => {
        console.log(error)

    });
}

let updateBoard = () => {
    let id = $('#input-id').val().replace("번", "");
    let formData = {
        id: id,
        title: $('#input-title').val(),
        content: $('.ck-editor__editable').html()
    }

    $.ajax({
        url: "/board/update",
        method: "post",
        data: formData,
        success: (response) => {
            let result = JSON.parse(response);
            console.log(result)
            Swal.fire({
                icon: result.status,
                text: result.message
            }).then(() => {
                location.href = result.nextPath;
            })
        }
    })
    console.log(formData);
}