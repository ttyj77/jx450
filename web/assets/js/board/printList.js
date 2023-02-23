let initPage = () => {
    let temp = new URLSearchParams(window.location.search).get('pageNo');

    let data;
    if (temp == null) {
        data = {'pageNo': 1}
    } else {
        data = {'pageNo': temp}
    }

    $.ajax({
        url: "/board/printList",
        method: "get",
        data: data,
        success: (message) => {
            console.log(message);
            let result = JSON.parse(message);
            let array = JSON.parse(result.data);
            console.log(typeof (array))
            console.log(array[0])
            array.forEach((b) => {
                insertRow(b)
            })
        }

    });
}

function insertRow(board) {
    let tbody = $('tbody');
    let pagination = $(tbody).children().last();

    $(tbody).remove(pagination);
    let tr = document.createElement('tr');
    $(tr).addClass("table-danger");
    $(tr).append($(document.createElement('td')).text(board.id.toString()));
    $(tr).append($(document.createElement('td')).text(board.title.toString()));
    $(tr).append($(document.createElement('td')).text(board.writerNickname.toString()));
    $(tr).append($(document.createElement('td')).text(board.entryDate.toString()));
    $(tr).append($(document.createElement('td')).text(board.modifyDate.toString()));

    $(tr).click(() => {
        location.href = '/board/printOne.jsp?id=' + board.id;
    })
    $(tbody).append(tr);
    $(tbody).append(pagination);

}