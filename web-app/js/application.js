if (typeof jQuery !== 'undefined') {
    (function ($) {
        $('#spinner').ajaxStart(function () {
            $(this).fadeIn();
        }).ajaxStop(function () {
                $(this).fadeOut();
            });
    })(jQuery);
}

$(document).ready(function () {
    $('.pagination').children().wrapAll('<ul>');
    $('.pagination ul').children().wrap('<li>');
    $('.sortable.sorted.asc a').append("\&nbsp\;<i class='cicon-sort-asc'></i>")
    $('.sortable.sorted.desc a').append("\&nbsp\;<i class='cicon-sort-desc'></i>")
    $('#datePicker').datepicker({
        dateFormat: 'd-M-yy',
        changeMonth: true,
        changeYear: true
    });
    $('#changePasswordForm').validate({
        rules: {
            currentPassword: {
                remote: checkPassword
            },
            password: {
                rangelength: [5, 10]
            },
            confirmPassword: {
                equalTo: "#password"
            }
        },
        messages: {
            currentPassword: {
                remote: "Incorrect Password!!"
            },
            password: {
                rangelength: "Please enter a value between 5 and 10 characters long!!"
            },
            confirmPassword: {
                equalTo: "Password and confirm password must be same!!"
            }
        }
    });
    $('#loginForm').validate();
    $('#recoverPasswordForm').validate();
    $('#registrationForm').validate({
        rules: {
            email: {
                remote: checkEmailUrl
            },
            password: {
                rangelength: [5, 10]
            },
            confirmPassword: {
                equalTo: "#password"
            }
        },
        messages: {
            email: {
                remote: "This email is already in use!!"
            },
            password: {
                rangelength: "Please enter a value between 5 and 10 characters long!!"
            },
            confirmPassword: {
                equalTo: "Password and confirm password must be same!!"
            }
        }
    });


});


function subscribeTopicViaAjax(id) {
    var seriousness = $('#seriousness' + id).attr('value');
    $.ajax({
        url: subscribeTopicUrl,
        data: {id: id, seriousness: seriousness}
    }).success(function (data) {
            $('#subscribeUnsubscribe' + id).html(data);
            $('#sendInvite' + id).attr('class', '')
        });
}

function unSubscribeTopicViaAjax(id) {
    $.ajax({
        url: unSubscribeTopicUrl,
        data: {id: id}
    }).success(function (data) {
            $('#subscribeUnsubscribe' + id).html(data);
            $('#sendInvite' + id).attr('class', 'hidden')
        });
}

function sendInviteViaAjax(id) {
    var email = $('#email').attr('value');
    $.ajax({
        url: sendInviteUrl,
        data: {email: email, topicId: id}
    });
    alert("Invitation send");
}

function resourceType() {
    if ($('#divResourceType input[name=resourceType]:radio:checked').attr('value') == 'documentResource') {
        $('#linkResource').hide();
        $('#documentResource').show();
    } else {
        $('#linkResource').show();
        $('#documentResource').hide();
    }
}

function markAsReadUnread(id) {
    $.ajax({
        url: markAsReadUnreadUrl,
        data: {id: id}
    }).success(function (data) {
            if (data == 'true') {
                $('a#isRead' + id).text('Mark as Unread');
                $('#readingItem' + id).attr('class', 'muted');
            } else {
                $('a#isRead' + id).text('Mark as Read');
                $('#readingItem' + id).attr('class', 'bold');

            }
        });
}

function toggleFavourite(id) {
    $.ajax({
        url: toggleFavouriteUrl,
        data: {id: id}
    }).success(function (data) {
            $('a#isFavourite' + id + '> i').attr('class', data);
        });
}

