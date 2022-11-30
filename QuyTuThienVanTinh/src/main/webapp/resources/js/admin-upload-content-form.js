        /* VALIDATE FORM => body-admin-form-edit.jsp + body-admin-form-create.jsp => FORM OF UPLOADING CONTENT OF A DONATION ROUND */
        $(document).ready(function () {
            var form = $('#admin-form'); 
            //var s = $('#startDate');
            //var e = $('#endDate');  


           
            /* last function will run in order */
            form.on('submit', function (event) {
                var start = new Date($('#startDate').val());
                var end = new Date ($('#endDate').val()); 
                console.log(start, end);
                if (validateStartLessThanEnd(start, end))
                    return true;
                return false;
            });

    

            /* start date must be less than end date */ 
            function validateStartLessThanEnd(start, end) {
                if (start <= end) {                   
                    return true;
                } else {
                    $('.end-date-message').text("Ngày bắt đầu phải trước ngày kết thúc").addClass('error-message');
                    return false;
                }
            }

        });





       