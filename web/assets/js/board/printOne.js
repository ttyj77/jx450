let initPage = () => {
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
                console.log(result.id)
                printReply(temp);
            } else if (result.status == "fail") {
                Swal.fire({title: "!!!!error!!!", text: result.message, icon: "error"}).then(() => {
                    location.href = result.nextPath;
                })
            }
        }

    });


}


function printData(data) {
    $('#td-id').text(data.id + "번");
    $('#td-title').text(data.title);
    $('#td-content').append(data.content);
    $('#td-entry-date').text(data.entryDate);
    $('#td-modify-date').text(data.modifyDate);
    $('#td-writer').text(data.writerNickname);
    if (data.isOwned == true) {
        console.log("r")
        let tr = $(document.createElement("tr"));
        let td = $(document.createElement("td")).attr("colspan", 2);

        let btnUpdate = $(document.createElement("div")).addClass('btn btn-success w-50 ').text("update").click(() => {
            location.href = "/board/update.jsp?id=" + data.id;
        });

        let btnDelete = $(document.createElement("div")).addClass('btn btn-danger w-50').text("delete").click(() => {
            let delData = {
                "id": data.id
            };
            $.ajax({
                url: "/board/delete",
                method: "post",
                data: delData,
                success: (message) => {
                    let response = JSON.parse(message);
                    console.log("response : " + response)
                    if (response.status == 'success') {
                        Swal.fire({title: "!!!삭제성공!!!", text: "성공적으로 글이 삭젱되습니다."}).then(() => {
                            location.href = "/board/printList.jsp?id=1"
                        })
                    } else {
                        Swal.fire({title: "!!!삭제실패!!!", text: "문제가 발생해 삭제 실패."})
                    }
                }
            })

            $.ajax({
                url: "/board/delete",
                method: "get",
                data: data,
                success: (message) => {
                    let response = JSON.parse(message);
                    console.log("response : " + response)
                    if (response.status == 'success') {
                        Swal.fire({title: "!!!삭제성공!!!", text: "성공적으로 글이 삭젱되습니다."}).then(() => {
                            location.href = "/board/printList.jsp?id=1"
                        })
                    } else {
                        Swal.fire({title: "!!!삭제실패!!!", text: "문제가 발생해 삭제 실패."})
                    }
                }

            });
        });

        $(td).append(btnUpdate);
        $(td).append(btnDelete);

        $(tr).append(td);
        $('#table-board').append(tr);
    }
}

