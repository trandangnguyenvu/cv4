        /*SHOW PASSWORDS*/
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
        
        // for password change task
        function myFunctionZ() {
            var z = document.getElementById("newpassword");
            if (z.type === "password") {
                z.type = "text";
            } else {
                z.type = "password";
            }
        }