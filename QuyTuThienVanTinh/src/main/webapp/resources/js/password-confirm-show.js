        /* VALIDATE FORM => user-register.jsp => a form for account registration */
        $(document).ready(function () {
            var form = $('#form');
            /*var password = $('#password');
            var confirm_password = $('#confirmpassword');*/
            var user = $('#user');
            var email = $('#email');
            var name = $('#name');
            var last_name = $('#last-name');
            var birth_date = $('#birth-date');
            var button = $('#send');


            /* validate PASS 
             */
            $('#password').on('keyup',  validatePass);
            function validatePass() {
                $('.pass-message').removeClass('success-message').removeClass('error-message');

                let password1 = $('#password').val(); 
                let regexp = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}/;

                if (password1 === "") {
                    $('.pass-message').text("Ô Mật khẩu không được để trống").addClass('error-message');
                    return false;
                }
                else if (regexp.test(password1)) {
                    $('.pass-message').text("Mật khẩu đã phù hợp với tiêu chuẩn").addClass('success-message');
                    return true;
                }
                else {
                    $('.pass-message').text("Mật khẩu phải chứa ít nhất 1 chữ số, 1 chữ cái viết hoa, 1 chữ cái thường, 1 ký tự đặc biệt và ít nhất 8 ký tự trở lên").addClass('error-message');
                    return false
                }
            }
            /* validate CONFIRM PASSWORDS 
             */
            $('#password, #confirmpassword').on('keyup', validateConfirmPass);
            function validateConfirmPass() {

                $('.confirm-message').removeClass('success-message').removeClass('error-message');

                let password = $('#password').val();
                let confirm_password = $('#confirmpassword').val();                
                if (password === "") {
                    $('.confirm-message').text("Ô Mật khẩu không được để trống").addClass('error-message');
                    return false;
                } /* Password Field cannot be empty */
                else if (confirm_password === "") {
                    $('.confirm-message').text("Ô Xác nhận không được để trống").addClass('error-message');
                    return false;
                } /* Confirm Password Field cannot be empty */
                else if (confirm_password === password) {
                    $('.confirm-message').text("Mật khẩu đã trùng khớp").addClass('success-message');
                    return true;
                } /* Password Match! */
                else {
                    $('.confirm-message').text("Mật khẩu chưa trùng khớp").addClass('error-message');
                    return false;
                } /* Password Doesn't Match! */
            }

            // last function in progress
            form.on('submit', function (event) {
                if (validateConfirmPass() && validateUser() && validateEmail() && validateName() && validateLastName() && validateBirthDay() && validatePass())
                    return true;
                return false;
            })

            

            user.blur(validateUser);
            email.blur(validateEmail);
            name.blur(validateName);
            last_name.blur(validateLastName);
            birth_date.blur(validateBirthDay);        

            user.keyup(validateUser);
            email.keyup(validateEmail);
            name.keyup(validateName);
            last_name.keyup(validateLastName);
            birth_date.keyup(validateBirthDay);



            /* validate of THE REST OF FORM 
             */
            function validateName() {
                $('.name-message').removeClass('success-message').removeClass('error-message');
                if (name.val() === "") { 
                    $('.name-message').text("Ô Tên không được để trống").addClass('error-message');
                    return false;
                } else {
                    $('.name-message').text("").addClass('success-message');
                    return true;
                }
            }

            function validateLastName() {
                $('.last-name-message').removeClass('success-message').removeClass('error-message');
                if (last_name.val() === "") { 
                    $('.last-name-message').text("Ô Họ và tên không được để trống").addClass('error-message');
                    return false;
                } else {
                    $('.last-name-message').text("").addClass('success-message');
                    return true;
                }
            }

            function validateUser() {
                $('.account-message').removeClass('success-message').removeClass('error-message');
                if (user.val() === "") { 
                    $('.account-message').text("Ô Tên tài khoản không được để trống").addClass('error-message');
                    return false;
                } else {
                    $('.account-message').text("").addClass('success-message');
                    return true;
                }
            }

            function validateEmail() {
                $('.email-message').removeClass('success-message').removeClass('error-message');
                let regexp = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/; 

                if (email.val() === "") { 
                    $('.email-message').text("Ô Email không được để trống").addClass('error-message');
                    return false;
                } else if(regexp.test(email.val())) { //if(regexp.test(email.val())) or (email.val().match(regexp))?
                    $('.email-message').text("Email hợp lệ").addClass('success-message');
                    return true;
                } else {
                    $('.email-message').text("Email không hợp lệ").addClass('error-message');
                    return false;
                }
            } //[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$ 
            // <input type="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" /> 
            // <input type="email" id="email" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"> 
            // regexp = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/; 
            // pattern of pass: pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*]).{8,}"
            // regexp = /[a-z0-9]+@[a-z]+\.[a-z]{2,3}/;
            // regexp = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            // regexp = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
            // [a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$ pattern from w3
            // regexp = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/; from w3schools.blog/
            // [a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,} from mentor

            function validateBirthDay() {
                if (birth_date.val.length > 0) {
                    return true;
                } else {
                    return false;
                }
            }

        });





        /* SHOW PASSWORDS (Js, NOT JQUERY)   
         */
        function myFunctionX() {
            var x = document.getElementById("password");
            if (x.type === "password") {
                x.type = "text";
            } else {
                x.type = "password";
            }
        }
        function myFunctionY() {
            var y = document.getElementById("confirmpassword");
            if (y.type === "password") {
                y.type = "text";
            } else {
                y.type = "password";
            }
        }
