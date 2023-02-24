let writeReply = () => {
    let formData = {
        'content': $('#input-reply').val(),
        'boardId': new URLSearchParams(window.location.search).get('id')
    };
    console.log(formData)


    $.ajax({
        url: "/reply/write",
        method: "post",
        data: formData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == "fail") {
                Swal.fire({
                    title: "11111 Error !!!",
                    text: "에러가 발생 했습니다.",
                    icon: "error"
                })
            }

            location.reload();
        }

    })
}

function printReply(boardId) {
    let sendData = {
        "boardId": boardId
    }
    $.ajax({
        url: "/reply/selectAll",
        method: "get",
        data: sendData,
        success: (message) => {
            let response = JSON.parse(message);
            console.log("response : " + response);
            let replyArray = JSON.parse(response.list);
            console.log(replyArray)
            printList(replyArray);
        }
    })
}

function printList(replyArray) {
    // let tr = $(document.createElement("tr"))
    // let td = $(document.createElement("td"))
    if (replyArray.length == 0) {
        $('#tbody-reply').append(
            $(document.createElement("tr")).append(
                $(document.createElement("td")).attr("colspan", "2").text("아직 등록 된 댓글이 존재하지 않습니다.")
            )
        );
    } else {
        replyArray.forEach(reply => {
            let tr = $(document.createElement("tr"))
            let td = $(document.createElement("td")).attr("colspan", "2");
            let str = reply.writer + ": " + reply.content + " at " + reply.date
            $(td).text(str)
            if (reply.isOwned == true) {
                let btnUpdate = $(document.createElement("div")).addClass("btn btn-success").text("update");
                btnUpdate.click(() => {
                    console.log(reply.id + "update");
                    updateUi(td, reply);
                })
                let btnDelete = $(document.createElement("div")).addClass("btn btn-danger").text("delete");
                btnDelete.click(() => {
                    deleteReply(reply.id);
                    console.log(reply.id + "delete");
                })
                $(td).append(btnUpdate);
                $(td).append(btnDelete);
            }
            $(tr).append(td)
            $('#tbody-reply').append(tr);
        })
    }
}

function deleteReply(id) {
    let sendData = {
        "id": id
    }
    $.ajax({
        url: "/reply/delete",
        method: "get",
        data: sendData,
        success: (message) => {
            let response = JSON.parse(message);
            console.log(response)
            if (response.status == "fail") {
                Swal.fire({text: "delete error", title: "!! error !! "})
            }
            location.reload();
        }
    })
}

function updateUi(td, reply) {
    console.log(td)
    let tr = $(td).parent();
    $(tr).html("")

    let form = $(document.createElement("input")).attr("type", text).addClass("form-control w-75").val(reply.content);
    let btnUpdate = $(document.createElement("div")).addClass("btn btn-success w-25").click(updateReply(reply));
    $(tr).append(form);
    $(tr).append(btnUpdate);


}

function updateReply(reply) {
    let content = $('#input-update' + reply.id).val();
    let formData = {
        "content": content,
        "id": reply.id
    };

    $.ajax({
        url: "/reply/update",
        method: "post",
        data: formData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == "fail") {
                Swql.fire({
                    "text": "update error",
                    "title": "!!! error !!!"
                });
            }
            location.reload();
        }
    })
}