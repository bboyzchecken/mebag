'use strict'
const Database = use("Database");
const User = use("App/Models/User");
const { validate } = use('Validator');
const Hash = use('Hash');
class UserController {

    async index({ view, response, session }) {
        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });
        const events = await Database.from('events');
        return view.render('welcome', {
            users: users,
            events: events,
            cart:session.get('cart')
        })
    }


    //ระบบสมาชิก
    async register_page({ view, response, session }) {
        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });
        return view.render('users/register', {
            users: users
        })
    }

    async register({ request, response, view }) {
        const GETDATA = request.post();
        const check_users = await Database.from('users').where('User_Email', GETDATA.User_Email);
        const pattern_eng = /^[a-zA-Z0-9\s]+$/;
        if (check_users == 0) {
            if (GETDATA.User_Password.length > 4 && GETDATA.User_Password.length < 26 && GETDATA.User_Password.match(pattern_eng)) {
                if (GETDATA.User_Password == GETDATA.confirm_password) {
                    let postId = await Database.table("users").insert({
                        User_FirstName: GETDATA.User_FirstName,
                        User_LastName: GETDATA.User_LastName,
                        User_Sex: GETDATA.User_Sex,
                        User_BirthDay: GETDATA.User_BirthDay,
                        User_Tel: GETDATA.User_Tel,
                        User_Email: GETDATA.User_Email,
                        User_Address: GETDATA.User_Address,
                        User_Password: await Hash.make(GETDATA.confirm_password.trim()),
                        User_Permission: '0'
                    });

                    await Database.table("verifies").insert({
                        User_ID: postId,
                    });
                    return view.render('users/register', { error: "สมัครสมาชิกสำเร็จ", alert: "alert-success" })
                } else {
                    return view.render('users/register', { error: "รหัสผ่านไม่ตรงกัน กรุณาตรวจสอบ", alert: "alert-danger" })
                }
            } else {
                return view.render('users/register', { error: "รูปแบบของรหัสผ่านไม่ถูกต้อง ไม่อณุญาตให้ใช้ภาษาไทยเป็นรหัสผ่าน หรือ รหัสผ่านน้อยกว่า 4 ตัวอักษร", alert: "alert-danger" })
            }

        } else {
            return view.render('users/register', { error: "อีเมลถูกใช้งานแล้ว", alert: "alert-danger" })
        }

    }

    async login({ request, response, view, session }) {
        let GETDATA = request.post();
        const users = await Database.from('users').where({
            'User_Email': GETDATA.email
        });



        const password = await Hash.verify(GETDATA.password, users[0].User_Password);
        if (users != 0) {
            if (password) {
                session.put('username', users[0].User_Email);
                session.put('User_ID', users[0].User_ID);
                return response.redirect("/account");
            } else {
                return view.render('users/login', { error: " รหัสผ่านไม่ถูกต้อง กรุณาตรวจสอบ" })
            }

        } else {
            return view.render('users/login', { error: "  อีเมล หรือ รหัสผ่านของท่านไม่ถูกต้อง กรุณาตรวจสอบ " })
        }

    }

    async account({ view, session }) {
        if (session.get('username')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('User_ID')
            });
            return view.render('users/account', { users: users })
        } else {
            return view.render('users/login', { error: "  กรุณาล็อกอินเข้าสู่ระบบ " })
        }
    }

    async login_check({ view, session, response }) {
        if (session.get('username')) {
            return response.redirect("/account");
        } else {
            return view.render('users/login')
        }
    }


    async logout({ response, session, view }) {
        session.clear()
        return response.redirect("/");
    }


    async add_cart({ response, session, view, request }) {
        let GETDATA = request.post();
        // return session.get('product_'+ GETDATA.Product_ID).qty;
        if (GETDATA.qty != 0) {
            if (session.get('cart')) {
                if (session.get('product_' + GETDATA.Product_ID)) {
                 /*    session.put('product_' + GETDATA.Product_ID, {
                        _csrf: GETDATA._csrf,
                        Product_ID: GETDATA.Product_ID,
                        Event_ID: GETDATA.Event_ID,
                        qty: parseInt(session.get('product_' + GETDATA.Product_ID).qty) + parseInt(GETDATA.qty)
                    }) */
                    // session.put(('product_' + GETDATA.Product_ID)['qty'], parseInt(session.get('product_'+ GETDATA.Product_ID).qty) + parseInt(GETDATA.qty));
                   // return response.redirect("back");return session.all();
                } else {
                    //session.put('cart', session.get('cart') + 1);
                    session.put('cart', {
                        products : GETDATA
                     });
                    return response.redirect("back");
                }
            } else {
                
                session.put('cart', {
                   products : GETDATA
                });
               // session.put('product_' + GETDATA.Product_ID, GETDATA);
               // session.put('cart'['product_'+GETDATA.Product_ID],GETDATA);
                return response.redirect("back");
            }
        } else {
      //   alert("กรุณาใส่จำนวนสินค้ามากกว่า 0");
         return response.redirect("back");
          //  return "ใส่ QTY > 0";
        }

        /* 
                   if (GETDATA.qty != 0) {
                       if (session.get('total')) {
                           if (session.get(GETDATA.Product_ID)) {
                               session.put('qty_' + GETDATA.Product_ID, parseInt(session.get('qty_' + GETDATA.Product_ID)) + parseInt(GETDATA.qty));
                               return session.all();
                               return "มี " + session.get(GETDATA.Product_ID) + " แล้ว :" + session.get('qty_' + GETDATA.Product_ID) + " ชิ้น จำนวนสินค้าทั้งหมดในตะกร้า " + session.get('total') + " สินค้า";
                           } else {
                               session.put('total', session.get('total') + 1);
                               session.put(GETDATA.Product_ID, GETDATA.Product_ID);
                               session.put('qty_' + GETDATA.Product_ID, parseInt(GETDATA.qty));
                               return session.all();
                               return "ใส่" + GETDATA.Product_ID + "ลงในตะกร้า จำนวน " + session.get('qty_' + GETDATA.Product_ID) + "ชิ้น เรียบร้อยแล้ว";
                           }
           
                       } else {
                           session.put('total', session.get('total') + 1);
                           session.put(GETDATA.Product_ID, GETDATA.Product_ID);
                           session.put('qty_' + GETDATA.Product_ID, parseInt(GETDATA.qty));
                           return session.all();
                           return "ใส่" + GETDATA.Product_ID + "ลงในตะกร้า จำนวน " + session.get('qty_' + GETDATA.Product_ID) + "ชิ้น เรียบร้อยแล้ว";
                       }
                   }else{
                       return "ใส่ QTY > 0";
                   }  */


        /* 
           session.put(GETDATA.Product_ID, GETDATA.Product_ID);
           return session.get(GETDATA.Product_ID); */
        /*    session.put('username', users[0].User_Email);
           session.put('User_ID', users[0].User_ID); */
    }

    async check_session({ response, session, view, request }) {
        return session.all();
        /*  return session.get('product_2').qty; */
        /* 
           session.put(GETDATA.Product_ID, GETDATA.Product_ID);
           return session.get(GETDATA.Product_ID); */
        /*    session.put('username', users[0].User_Email);
           session.put('User_ID', users[0].User_ID); */
    }

    upload_image({ request, response }) {

    }

    change_password({ request, response }) {

    }

    forgot_password({ request, response }) {

    }

    select_accout({ request, response }) {

    }

    edit_accout({ request, response }) {

    }

    ///ส่วนของการซ์ื้อของฉัน

    select_topay({ request, response }) {

    }

    select_torecive({ request, response }) {

    }

    select_success({ request, response }) {

    }

    select_cancel({ request, response }) {

    }

    select_event({ request, response }) {

    }

    payment({ request, response }) {

    }

    register_dealer({ request, response }) {

    }

    async event_detail({ params, view, session, request, response }) {
        const event_id = await params.event_id;

        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });

        const event_detail = await Database.from('events').where({
            'Event_ID': event_id
        });

        const profiles = await Database.from('users').where({
            'User_ID': event_detail[0].Event_Whose
        });

        if (event_detail != 0) {

            const event_image = await Database.from('event_images').where({
                'Event_ID': event_id
            });

            const products = await Database.from('products').where({
                'Event_ID': event_id
            });

            const all_events = await Database.from('events').orderBy('Event_ID', 'desc').limit(4);

            return view.render('users/event_detail', {
                users: users,
                events: event_detail,
                images: event_image,
                products: products,
                event_id: event_id,
                all_events: all_events,
                profiles: profiles
            })
        } else {
            return response.redirect("back");
        }


    }

}


module.exports = UserController
