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
            let totalPage = (result.totalPage);
            insertPagination(totalPage, data.pageNo);
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

function insertPagination(totalPage, pageNo) {
    console.log(pageNo)
    var startNum, endNum;
    if (parseInt(totalPage) <= 5) {
        startNum = 1;
        endNum = totalPage;
    } else if (parseInt(pageNo) < 3) {
        startNum = 1;
        endNum = 5;
    } else if (parseInt(pageNo) > totalPage - 3) {
        startNum = totalPage - 4;
        endNum = totalPage;
    } else {
        startNum = parseInt(pageNo) - 2;
        endNum = parseInt(pageNo) + 2;
    }
    // let tr = document.createElement("tr");
    // let td = $(document.createElement("td")).attr("colspan", "5");
    let ul = $(document.createElement("ul")).addClass("pagination  justify-content-center m-auto")
    let li = $(document.createElement("li")).addClass("page-link page-end");
    let firstAnchor = $(document.createElement("a")).add("page-link").attr("href", "/board/printList.jsp?pageNo=1");
    let firstButton = $(document.createElement("span")).text("<<");
    $(firstAnchor).append(firstButton);
    $(li).append(firstAnchor);
    $(ul).append(li);
    console.log(startNum, endNum)
    for (var i = startNum; i <= endNum; i++) {
        let page_li = $(document.createElement("li")).addClass("page-link");
        let anchor = $(document.createElement("a")).addClass("page-item").attr("href", "/board/printList.jsp?pageNo=" + i);
        if (i == pageNo) {
            anchor.addClass("active");
        }
        let span = $(document.createElement("span")).text(i);
        $(anchor).append(span);
        $(page_li).append(anchor);
        $(ul).append(page_li);
    }

    let lastLi = $(document.createElement("li")).addClass("page-link page-end");
    let lastAnchor = $(document.createElement("a")).add("page-link").attr("href", "/board/printList.jsp?pageNo=" + totalPage);
    let lastButton = $(document.createElement("span")).text(">>");

    $(lastAnchor).append(lastButton);
    $(lastLi).append(lastAnchor);
    $(ul).append(lastLi);

    // $(td).append(ul);
    // $(tr).append(td)
    $('#td-pagination').append(ul);

}