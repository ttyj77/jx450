

let auth = () => {
    let username = $('#username').val();
    let password = $('#password').val();

    let data = {
        "username": username,
        "password": password
    };
    $.ajax({
        url: "/user/auth",
        type: "post",
        data: data,
        success: function (message) {
            let result = JSON.parse(message) //json 객체로 만들어주기
            console.log(typeof result);
            if (result.result == 'success') {
                location.href = "/board/printList.jsp";
            } else {
                console.log("로그인 실패")
                Swal.fire({title: '로그인 실패', text: result.message});
            }
        }
    });

}
