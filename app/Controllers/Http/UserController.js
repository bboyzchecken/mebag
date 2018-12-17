'use strict'
const Database = use("Database");
const User = use("App/Models/User");
const { validate } = use('Validator');
const Hash = use('Hash');
const lodash = require('lodash');
const Helpers = use('Helpers')
const Encryption = use('Encryption');
const format = use('date-format');
const Mail = use('Mail')
const Chance = require('chance');

class UserController {
    async reset_password({ request, session, response, faker }) {
        //  const data = request.only(['email', 'username', 'password'])
        // const user = await User.create(data)
        let data = request.post();

        let users = await Database.from('users').where('User_Email', '=', data.email);
        if (users.length > 0) {
            let faker = new Chance();
            let temp_password = faker.string({ length: 8 });
            //return faker.string({length:8});
            let update = await Database.table('Users').update({
                User_Password: await Hash.make(temp_password),
            })
            let status = await Mail.send('users/reset_password', {
                password: temp_password,
                fullname: users[0].User_FirstName + ' ' + users[0].User_LastName,
                username: users[0].User_Email
            }, (message) => {
                message
                    .to(data.email)
                    .from('jiraphatsintuwong@outlook.com')
                    .subject('Reset Password [MEBAG.COM]')
            })
            session.flash({ success: 'ทำการตั้งค่ารหัสผ่านใหม่สำเร็จ กรุณาตรวจสอบในอีเมลของท่าน' })
            return response.redirect('back')
        } else {
            session.flash({ error: 'ไม่พบบัญชีผู้ใช้นี้ในระบบ กรุณาตรวจสอบ' })
            return response.redirect('back');
        }




    }
    async subscribe({ request, session, response, faker }) {

        let data = request.post();


        let check = await Database.from('subscribes').where('Sub_Email', '=', data.email);

        if (check) {
            session.flash({
                exit: '1'
            })
            return response.redirect('back')
        } else {
            let subscribe = await Database.table('subscribes').insert({
                Sub_Email: data.email
            });
            if (subscribe) {
                session.flash({
                    success: 'ติดตามข่าวสารสำเร็จ ขอบคุณที่ใช้บริการ'
                })
                return response.redirect('back')
            } else {
                session.flash({
                    error: 'ไม่สารมารถทำรายการได้ กรุณาตรวจสอบ'
                })
                return response.redirect('back')
            }
        }



    }
    async forget_password({ view, response, session }) {
        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });



        return view.render('users/forget_password', {
            users: users,

            carts: session.get('cart'),
            sum_product: session.get('sum_product'),
            sum_event: session.get('sum_event'),
        })
    }
    async profile({ view, response, session ,params}) {
        let profile_id = params.user_id;
        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });
        let profile = await Database.from('users').where({
            User_ID : profile_id
        })
        let event_recent = await Database.from('events').where('Event_Whose','=',profile_id).orderBy('Event_ID','desc').limit(3);



        return view.render('users/profile', {
            users: users,
            profile:profile,
            carts: session.get('cart'),
            events:event_recent,
            sum_product: session.get('sum_product'),
            sum_event: session.get('sum_event'),
        })
    }
    async index({ view, response, session }) {
        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });

        const events = await Database.from('events').limit(4).orderBy('Event_ID', 'desc');

        return view.render('welcome', {
            users: users,
            events: events,
            carts: session.get('cart'),
            sum_product: session.get('sum_product'),
            sum_event: session.get('sum_event'),
        })
    }
    async search({ view, response, session, params, request }) {
        let search = request.post();
        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });


        const events = await Database.from('events').where('events.Event_Detail', 'LIKE', '%' + search.keyword + '%').orWhere('events.Event_Name', 'LIKE', '%' + search.keyword + '%').orWhere('events.Event_Place', 'LIKE', '%' + search.keyword + '%').orderBy('events.Event_ID', 'desc');

        if (events.length > 0) {
            return view.render('users/search', {
                users: users,
                events: events,
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
            })
        } else {
            return view.render('users/search', {
                users: users,
                events: events,
                error: "ไม่เจอผลลัพธ์",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
            })
        }

    }
    async search_get({ response }) {
        return response.redirect('/')
    }
    //ระบบสมาชิก
    async register_page({ view, response, session }) {
        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });
        return view.render('users/register', {
            users: users,
            carts: session.get('cart'),
            sum_product: session.get('sum_product'),
            sum_event: session.get('sum_event'),
        })
    }

    async register({ request, response, view, session }) {
        const GETDATA = request.post();
        const check_users = await Database.from('users').where('User_Email', GETDATA.User_Email);
        const pattern_eng = /^[a-zA-Z0-9\s]+$/;
        if (check_users == 0) {
            if (GETDATA.User_Password.length > 6 && GETDATA.User_Password.length < 26 && GETDATA.User_Password.match(pattern_eng)) {
                if (GETDATA.User_Password == GETDATA.confirm_password) {
                    let postId = await Database.table("users").insert({
                        User_FirstName: GETDATA.User_FirstName,
                        User_LastName: GETDATA.User_LastName,
                        User_Sex: GETDATA.User_Sex,
                        User_BirthDay: GETDATA.User_BirthDay,
                        User_Tel: GETDATA.User_Tel,
                        User_Email: GETDATA.User_Email,
                        User_Image: 0,
                        User_Address: GETDATA.User_Address,
                        User_Password: await Hash.make(GETDATA.confirm_password.trim()),
                        User_Permission: '0'
                    });

                    await Database.table("verifies").insert({
                        User_ID: postId,
                    });
                    return view.render('users/register', {
                        error: "สมัครสมาชิกสำเร็จ",
                        alert: "alert-success",
                        sum_product: session.get('sum_product'),
                        sum_event: session.get('sum_event'),
                        carts: session.get('cart'),
                    })
                } else {
                    return view.render('users/register', {
                        error: "รหัสผ่านไม่ตรงกัน กรุณาตรวจสอบ",
                        alert: "alert-danger",
                        sum_product: session.get('sum_product'),
                        sum_event: session.get('sum_event'),
                        carts: session.get('cart'),
                    })
                }
            } else {
                return view.render('users/register', {
                    error: "รูปแบบของรหัสผ่านไม่ถูกต้อง ไม่อณุญาตให้ใช้ภาษาไทยเป็นรหัสผ่าน หรือ รหัสผ่านน้อยกว่า 6 ตัวอักษร",
                    alert: "alert-danger",
                    sum_product: session.get('sum_product'),
                    sum_event: session.get('sum_event'),
                    carts: session.get('cart'),
                })
            }

        } else {
            return view.render('users/register', {
                error: "อีเมลถูกใช้งานแล้ว",
                alert: "alert-danger",
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
                carts: session.get('cart'),
            })
        }

    }

    async login({ request, response, view, session }) {
        let GETDATA = request.post();
        const users = await Database.from('users').where({
            'User_Email': GETDATA.email
        });




        if (users != 0) {
            const password = await Hash.verify(GETDATA.password, users[0].User_Password);
            if (password) {
                session.put('username', users[0].User_Email);
                session.put('User_ID', users[0].User_ID);
                return response.redirect("/account");
            } else {
                return view.render('users/login', {
                    error: " รหัสผ่านไม่ถูกต้อง กรุณาตรวจสอบ",
                    carts: session.get('cart'),
                    sum_product: session.get('sum_product'),
                    sum_event: session.get('sum_event'),
                })
            }

        } else {
            return view.render('users/login', {
                error: "  อีเมล หรือ รหัสผ่านของท่านไม่ถูกต้อง กรุณาตรวจสอบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
            })
        }

    }

    async account({ view, session }) {

        if (session.get('username')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('User_ID')
            });

            return view.render('users/account', {
                users: users,
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
            })
        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),

            })
        }
    }


    async bedealer_page({ response, session, view }) {
        if (session.get('username')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('User_ID')
            });

            if (users[0].User_Permission == '1') {
                const verifies = await Database.from('verifies').where({
                    'User_ID': session.get('User_ID')
                });
                return view.render('users/bedealer', {
                    users: users,
                    verify: verifies,
                    carts: session.get('cart'),
                    sum_product: session.get('sum_product'),
                    sum_event: session.get('sum_event'),
                })
            } else {
                return view.render('users/bedealer', {
                    users: users,
                    carts: session.get('cart'),
                    sum_product: session.get('sum_product'),
                    sum_event: session.get('sum_event'),
                })
            }


        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),

            })
        }
    }
    async bedealer_register({ response, session, view, request }) {
        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });
        const Verify_Image = request.file('Verify_Image', {
            types: ['image'],
            size: '20mb'
        })
        if (session.get('username')) {
            //สมัครเป็นคนรับหิ้ว

            await Verify_Image.moveAll(Helpers.publicPath('assets/fileuploads/verify/' + session.get('User_ID')), (file) => {
                return {
                    name: session.get('User_ID') + "_" + Encryption.encrypt(file.fileName) + "." + `${file.subtype}`
                }
            })



            if (Verify_Image.movedAll()) {

                let GETDATA = request.post();

                let bedealer = await Database.table("verifies").where('User_ID', session.get('User_ID')).update({
                    Verify_BankImage: Verify_Image['_files'][1].fileName,
                    Verify_CardImage: Verify_Image['_files'][0].fileName,
                    Verify_BankName: GETDATA.Verify_BankName,
                    Verify_BankNumber: GETDATA.Verify_BankNumber,
                    Verify_CardID: GETDATA.Verify_CardID
                });

                if (bedealer) {
                    let update_permisson = await Database.table("users").where('User_ID', session.get('User_ID')).update({
                        User_Permission: 3,
                    });
                    if (update_permisson) {
                        session.flash({ notification: 'สมัครเป็นผู้รับหิ้วเรียบร้อยแล้ว กรุณารอแอดมินตรวจสอบเอกสารและอนุมัติ' })
                        return response.redirect('/bedealer');
                    } else {
                        return view.render('users/bedealer', {
                            users: users,
                            error: "ไม่สามารถอัพเดตสมัครเป็นคนรับหิ้วได้ โปรดตรวจสอบข้อมูล และติดต่อเจ้าหน้าที่",
                            carts: session.get('cart'),
                            sum_product: session.get('sum_product'),
                            sum_event: session.get('sum_event'),
                        })
                    }

                } else {
                    return view.render('users/bedealer', {
                        users: users,
                        error: "ไม่สามารถสมัครเป็นคนรับหิ้วได้ โปรดตรวจสอบข้อมูล และติดต่อเจ้าหน้าที่",
                        carts: session.get('cart'),
                        sum_product: session.get('sum_product'),
                        sum_event: session.get('sum_event'),
                    })
                }
            } else {
                return view.render('users/bedealer', {
                    users: users,
                    error: "ไม่สามารถอัพโหลดรูปเอกสารได้ โปรดตรวจสอบข้อมูล และติดต่อเจ้าหน้าที่",
                    carts: session.get('cart'),
                    sum_product: session.get('sum_product'),
                    sum_event: session.get('sum_event'),
                })
            }


        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),

            })
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
        session.forget('username');
        session.forget('User_ID');
        return response.redirect("/");
    }



    async add_cart({ response, session, view, request }) {
        let GETDATA = request.post();
        const products = await Database.from('products').innerJoin('events', 'products.Event_ID', 'events.Event_ID').where({
            'products.Product_ID': GETDATA.Product_ID
        });
        // return product;
        if (GETDATA.qty != 0) {
            if (session.get('cart')) {
                const result = session.get('cart').find(product => product.Product_Key === "product_" + products[0].Product_ID);
                //console.log(result)
                if (result) {
                    session.put('sum_transport', parseFloat(session.get('sum_transport')) + (parseFloat(GETDATA.qty) * parseFloat(products[0].Event_TransportPrice)));
                    session.put('sum_product', parseFloat(session.get('sum_product')) + (parseFloat(GETDATA.qty) * parseFloat(products[0].Product_Price)));
                    session.put('sum_event', parseFloat(session.get('sum_event')) + (parseFloat(GETDATA.qty) * parseFloat(products[0].Event_Price)));
                    const index = session.get('cart').findIndex(product => product.Product_Key === "product_" + products[0].Product_ID);
                    session.get('cart')[index].qty = parseInt(session.get('cart')[index].qty) + parseInt(GETDATA.qty);

                    /*   session.get('sum_product') = (parseFloat(session.get('sum_product'))) + (parseFloat(GETDATA.qty) * parseFloat(GETDATA.Product_Price));
                      session.get('sum_event') = (parseFloat(session.get('sum_event'))) + (parseFloat(GETDATA.qty) * parseFloat(GETDATA.Event_Price)); */
                    return response.redirect("back");
                } else {
                    session.get('cart').push({
                        Product_Key: "product_" + products[0].Product_ID,
                        Product_ID: products[0].Product_ID,
                        Product_Name: products[0].Product_Name,
                        Product_Type: products[0].Product_Type,
                        Event_Name: products[0].Event_Name,
                        Event_Whose: products[0].Event_Whose,
                        Product_Price: products[0].Product_Price,
                        Event_ID: products[0].Event_ID,
                        Event_CoverImage: products[0].Event_CoverImage,
                        Event_Price: products[0].Event_Price,
                        Event_TransportPrice: products[0].Event_TransportPrice,
                        qty: GETDATA.qty
                    });
                    session.put('sum_transport', parseFloat(session.get('sum_transport')) + (parseFloat(GETDATA.qty) * parseFloat(products[0].Event_TransportPrice)));
                    session.put('sum_product', parseFloat(session.get('sum_product')) + (parseFloat(GETDATA.qty) * parseFloat(products[0].Product_Price)));
                    session.put('sum_event', parseFloat(session.get('sum_event')) + (parseFloat(GETDATA.qty) * parseFloat(products[0].Event_Price)));
                    /*  session.get('sum_product') = parseFloat(session.get('sum_product')) + (parseFloat(GETDATA.qty) * parseFloat(GETDATA.Product_Price));
                     session.get('sum_event') = parseFloat(session.get('sum_event')) + (parseFloat(GETDATA.qty) * parseFloat(GETDATA.Event_Price)); */
                    return response.redirect("back");
                }
            } else {

                let cart = [];
                cart.push({
                    Product_Key: "product_" + products[0].Product_ID,
                    Product_ID: products[0].Product_ID,
                    Product_Name: products[0].Product_Name,
                    Product_Type: products[0].Product_Type,
                    Event_Name: products[0].Event_Name,
                    Event_Whose: products[0].Event_Whose,
                    Product_Price: products[0].Product_Price,
                    Event_ID: products[0].Event_ID,
                    Event_CoverImage: products[0].Event_CoverImage,
                    Event_Price: products[0].Event_Price,
                    Event_TransportPrice: products[0].Event_TransportPrice,
                    qty: GETDATA.qty
                });

                //let re_key = lodash.keyBy(cart, "Product_Key");
                session.put('sum_transport', parseFloat(GETDATA.qty) * parseFloat(products[0].Event_TransportPrice));
                session.put('sum_product', parseFloat(GETDATA.qty) * parseFloat(products[0].Product_Price));
                session.put('sum_event', parseFloat(GETDATA.qty) * parseFloat(products[0].Event_Price));
                session.put('cart', cart);
                return response.redirect("back");
                return session.get('cart')[GETDATA.Product_Key];
            }
        }

    }

    async check_session({ response, session, view, request }) {
        return session.all();

    }


    async clear_cart({ response, session, view, request }) {
        session.forget('cart');
        session.put('sum_transport', parseFloat(0));
        session.put('sum_product', parseFloat(0));
        session.put('sum_event', parseFloat(0));
        return response.redirect("back");
    }

    async del_cart({ response, session, view, params }) {
        const Product_Key = await params.product_key;
        const index = session.get('cart').findIndex(product => product.Product_Key === Product_Key);
        session.put('sum_product', parseInt(session.get('sum_product')) - (parseFloat(session.get('cart')[index].qty) * parseFloat(session.get('cart')[index].Product_Price)));
        session.put('sum_event', parseInt(session.get('sum_event')) - (parseFloat(session.get('cart')[index].qty) * parseFloat(session.get('cart')[index].Event_Price)));
        session.put('sum_transport', parseInt(session.get('sum_transport')) - (parseFloat(session.get('cart')[index].qty) * parseFloat(session.get('cart')[index].Event_TransportPrice)));
        (session.get('cart')).splice(index, 1);
        return response.redirect("back");
    }

    async del_session({ response, session, view, params }) {
        session.clear();
        return response.redirect("back");
    }
    async view_cart({ response, session, view, params }) {

        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });
        let event_uniq = lodash.uniqBy(session.get('cart'), 'Event_ID');

        let event_loop = lodash.map(event_uniq, 'Event_ID');

        //return lodash.map(event_uniq,'Event_ID');
        // const index = session.get('cart').findIndex(product => product.Product_Key === Product_Key);
        return view.render('users/view_cart', {
            users: users,
            carts: session.get('cart'),
            sum_product: session.get('sum_product'),
            sum_event: session.get('sum_event'),
            sum_transport: session.get('sum_transport'),
            event_loop: event_uniq,
        });

    }

    async checkout({ response, session, view, params }) {

        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });

        if (session.get('User_ID')) {
            if (session.get('cart')) {


                let event_uniq = lodash.uniqBy(session.get('cart'), 'Event_ID');
                let event_loop = lodash.map(event_uniq, 'Event_ID');

                let sum_event = 0;
                let sum_product = 0;
                let sum_transport = 0;
                let obj_sum = [];
                const test = session.get('cart').find(product => product.Event_ID === 17);

                for (let index = 0; index < event_loop.length; index++) {
                    const result_cart = session.get('cart').find(product => product.Event_ID === event_loop[index]);
                    // console.log(event_loop[index])

                    for (let cart_index = 0; cart_index < session.get('cart').length; cart_index++) {
                        if (session.get('cart')[cart_index].Event_ID == event_loop[index]) {
                            sum_event = parseFloat(sum_event) + parseFloat(session.get('cart')[cart_index].qty) * parseFloat(session.get('cart')[cart_index].Event_Price);
                            sum_product = parseFloat(sum_product) + parseFloat(session.get('cart')[cart_index].qty) * parseFloat(session.get('cart')[cart_index].Product_Price);
                            sum_transport = parseFloat(sum_transport) + parseFloat(session.get('cart')[cart_index].qty) * parseFloat(session.get('cart')[cart_index].Event_TransportPrice);
                        }

                    }
                    /*  console.log(sum_event)
                     console.log(sum_product)
                     console.log(sum_transport) */
                    const checkout_id = await Database.table("orders").insert({
                        Order_Whose: session.get('User_ID'),
                        Order_ToWho: result_cart.Event_Whose,
                        Event_ID: result_cart.Event_ID,
                        Event_Name: result_cart.Event_Name,
                        Order_SumEvent: sum_event,
                        Order_SumTransport: sum_transport,
                        Order_SumProduct: sum_product,
                        Order_Total: parseFloat(sum_event) + parseFloat(sum_transport) + parseFloat(sum_product),
                        Order_Status: '0',
                        Order_date: format.asString('dd-MM-yyyy', new Date())
                    });
                    //event_loop คือ  ไอดี Event  id event and product ยัด product all ลงใน detail order
                    for (let cart_index = 0; cart_index < session.get('cart').length; cart_index++) {
                        if (session.get('cart')[cart_index].Event_ID == event_loop[index]) {
                            let detail_id = await Database.table("order_details").insert({
                                Order_ID: checkout_id,
                                Product_ID: session.get('cart')[cart_index].Product_ID,
                                Product_Name: session.get('cart')[cart_index].Product_Name,
                                Product_Type: session.get('cart')[cart_index].Product_Type,
                                Product_Price: session.get('cart')[cart_index].Product_Price,
                                qty: session.get('cart')[cart_index].qty
                            });
                            /*   console.log(session.get('cart')[cart_index]) */
                            if (!detail_id) {
                                session.flash({ error: 'ไม่สามารถ checkout ได้' })
                                return response.redirect('back');
                            }
                        }


                    }
                    //console.log('++++++++++++++++++++++++')


                    if (!checkout_id) {
                        session.flash({ error: 'ไม่สามารถ checkout ได้' })
                        return response.redirect('back');
                    }
                    sum_event = 0;
                    sum_product = 0;
                    sum_transport = 0;
                }
                session.forget('cart');
                session.put('sum_transport', parseFloat(0));
                session.put('sum_product', parseFloat(0));
                session.put('sum_event', parseFloat(0));
                session.flash({ success: 'สั่งสินค้าเรียบร้อยแล้ว กรุณาตรวจสอบใน การซื้อของฉัน' })
                return response.redirect('back');
            } else {
                session.flash({ error: 'ไม่มีสินค้าในตะกร้า' })
                return response.redirect('back');
            }

        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),

            })
        }




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
                profiles: profiles,
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
            })
        } else {
            return response.redirect("back");
        }


    }

    async all_events({ params, view, session, request, response }) {
        let page = params.page;

        const users = await Database.from('users').where({
            'User_ID': session.get('User_ID')
        });
        let events; let event_cheap; let event_expensive; let event_end;

        if (page) {
            events = await Database.from('events').orderBy('Event_ID', 'desc').paginate(page, 9);
            event_cheap = await Database.from('events').orderBy('Event_Price', 'asc').paginate(page, 9);
            event_expensive = await Database.from('events').orderBy('Event_Price', 'desc').paginate(page, 9);


        } else {
            events = await Database.from('events').orderBy('Event_ID', 'desc').paginate(1, 9);
            event_cheap = await Database.from('events').orderBy('Event_Price', 'asc').paginate(1, 9);
            event_expensive = await Database.from('events').orderBy('Event_Price', 'desc').paginate(1, 9);
        }



        const event_widget = await Database.from('events').orderBy('Event_ID', 'desc').limit(4).orderBy('Event_ID', 'desc');
        let totalPage = Math.ceil(parseInt(events.total) / parseInt(events.perPage));

        return view.render('users/all_events', {
            users: users,
            events: events,
            carts: session.get('cart'),
            sum_product: session.get('sum_product'),
            sum_event: session.get('sum_event'),
            event_widget: event_widget,
            totalPage: totalPage,
            event_cheap: event_cheap,
            event_expensive: event_expensive
        })

    }

    async history({ params, view, session, request, response }) {
        // let event_uniq = lodash.uniqBy(session.get('cart'), 'Event_ID');
        if (session.get('username')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('User_ID')
            });
            //ออเดอร์รอคนหิ้วรับ
            const orders_wait = await Database.from('orders').innerJoin('order_details', 'orders.Order_ID', 'order_details.Order_ID').innerJoin('events', 'orders.Event_ID', 'events.Event_ID').where({
                'Order_Whose': session.get('User_ID'),
                'Order_Status': '0'
            });
            let events_wait = lodash.uniqBy(orders_wait, 'Order_ID');

            //ออเดอร์ที่คนหิ้วรับแล้วแต่รอจ่าย 
            const orders_topay = await Database.from('orders').innerJoin('order_details', 'orders.Order_ID', 'order_details.Order_ID').innerJoin('events', 'orders.Event_ID', 'events.Event_ID').where({
                'Order_Whose': session.get('User_ID'),
                'Order_Status': 'accept'
            });
            let events_topay = lodash.uniqBy(orders_topay, 'Order_ID');
            //ออเดอร์ที่จ่ายแล้วรอแอดมินตรวจสอบ          
            //ออเดอร์ที่แอดมินอนุมัติแล้วรอรับ
            const orders_torecive = await Database.from('orders').innerJoin('order_details', 'orders.Order_ID', 'order_details.Order_ID').innerJoin('events', 'orders.Event_ID', 'events.Event_ID').where({
                'Order_Whose': session.get('User_ID'),
                'Order_Status': 'paid'
            });
            let events_torecive = lodash.uniqBy(orders_torecive, 'Order_ID');
            //ออเดอร์ที่กดรับของเรียบร้อยแล้ว
            const orders_success = await Database.from('orders').innerJoin('order_details', 'orders.Order_ID', 'order_details.Order_ID').innerJoin('events', 'orders.Event_ID', 'events.Event_ID').where({
                'Order_Whose': session.get('User_ID'),
                'Order_Status': 'success'
            });
            let events_success = lodash.uniqBy(orders_success, 'Order_ID');
            //ออเดอร์ที่คนหิ้วไม่รับ
            const order_cancel = await Database.from('orders').innerJoin('order_details', 'orders.Order_ID', 'order_details.Order_ID').innerJoin('events', 'orders.Event_ID', 'events.Event_ID')
                .where({
                    'Order_Whose': session.get('User_ID'),
                    'Order_Status': 'reject'

                }).orWhere({
                    'Order_Whose': session.get('User_ID'),
                    'Order_Status': 'cancel'
                }).orWhere({
                    'Order_Whose': session.get('User_ID'),
                    'Order_Status': 'reject_recive'
                });
            let events_cancel = lodash.uniqBy(order_cancel, 'Order_ID');



            return view.render('users/history', {
                users: users,
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
                orders_wait: orders_wait,
                orders_topay: orders_topay,
                orders_torecive: orders_torecive,
                orders_success: orders_success,
                order_cancel: order_cancel,
                events_wait: events_wait,
                events_topay: events_topay,
                events_torecive: events_torecive,
                events_success: events_success,
                events_cancel: events_cancel,

            })
        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),

            })
        }

    }
    async upload_image({ params, view, session, request, response }) {
        if (session.get('username')) {

            const profilePic = request.file('profile', {
                types: ['image'],
                size: '2mb'
            })


            await profilePic.moveAll(Helpers.publicPath('assets/fileuploads/profilepicture/' + session.get('User_ID')), (file) => {
                return {
                    name: session.get('User_ID') + "_" + Encryption.encrypt(file.fileName) + "." + `${file.subtype}`
                }
            })

            if (profilePic.movedAll()) {
                let update = await Database.table('users').where('User_ID', session.get('User_ID')).update({
                    User_Image: profilePic['_files'][0].fileName
                });

                if (update) {
                    session.flash({ success: 'อัพโหลดรูปสำเร็จ ' })
                    return response.redirect('back');
                } else {
                    session.flash({ error: 'อัพโหลดไม่สำเร็จ' })
                    return response.redirect('back');
                }

            } else {
                session.flash({ error: profilePic.errors() })
                return response.redirect('back');
            }
        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),

            })
        }

    }
    async edit_profile({ params, view, session, request, response }) {
        if (session.get('username')) {
            let DATA = request.post();
            let update = await Database.table('users').where('User_ID', session.get('User_ID')).update({
                User_FirstName: DATA.User_FirstName,
                User_LastName: DATA.User_LastName,
                User_BirthDay: DATA.User_BirthDay,
                User_Address: DATA.User_Address,
                User_Tel: DATA.User_Tel,
                User_Sex: DATA.User_Sex,
            });
            if (update) {
                session.flash({ success: 'แก้ไขข้อมูลสำเร็จ ' })
                return response.redirect('back');
            } else {
                session.flash({ error: 'แก้ไขข้อมูลไม่สำเร็จ' })
                return response.redirect('back');
            }
        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),

            })
        }

    }
    async change_password_page({ params, view, session, request, response }) {
        if (session.get('username')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('User_ID')
            });

            return view.render('users/password', {
                users: users,
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
            })
        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),

            })
        }

    }
    async password_change({ params, view, session, request, response }) {
        if (session.get('username')) {
            let DATA = request.post();
            const users = await Database.from('users').where({
                'User_ID': session.get('User_ID')
            });

            const password = await Hash.verify(DATA.oldpassword, users[0].User_Password);

            if (password) {
                const pattern_eng = /^[a-zA-Z0-9\s]+$/;
                if (DATA.confirmpassword.length > 6 && DATA.confirmpassword.length < 26 && DATA.confirmpassword.match(pattern_eng)) {
                    if (DATA.confirmpassword == DATA.newpassword) {
                        let update = await Database.table('users').where('User_ID', session.get('User_ID')).update({
                            User_Password: await Hash.make(DATA.confirmpassword.trim())
                        });
                        if (update) {
                            session.flash({ success: 'เปลี่ยนรหัสผ่านสำเร็จ ' })
                            return response.redirect('back');
                        } else {
                            session.flash({ error: 'เปลี่ยนรหัสผ่านไม่สำเร็จ กรุณาติดต่อเจ้าหน้าที่' })
                            return response.redirect('back');
                        }
                    } else {
                        session.flash({ error: 'เปลี่ยนรหัสผ่านไม่สำเร็จ กรุณากรอกรหัสผ่านตรงกัน' })
                        return response.redirect('back');
                    }
                } else {
                    session.flash({ error: 'เปลี่ยนรหัสผ่านไม่สำเร็จ รูปแบบของรหัสผ่านไม่ถูกต้อง ไม่อณุญาตให้ใช้ภาษาไทยเป็นรหัสผ่าน หรือ รหัสผ่านน้อยกว่า 4 ตัวอักษร' })
                    return response.redirect('back');
                }

            } else {
                session.flash({ error: 'รหัสผ่านไม่ถูกต้อง' })
                return response.redirect('back');
            }

        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),

            })
        }

    }
    async payment_page({ params, view, session, request, response }) {
        let order_id = params.order_id;
        if (session.get('username')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('User_ID')
            });

            let orders = await Database.from('orders').where({
                'Order_ID': order_id,
                'Order_Whose': session.get('User_ID'),
                Order_Status: 'accept'
            });
            if (orders.length < 1) {
                session.flash({ error: 'ไม่มีออเดอร์นี้อยู่ กรุณาตรวจสอบ' })
                return response.redirect('/history');
            }

            return view.render('users/payment', {
                users: users,
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
                orders: orders
            })
        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),

            })
        }

    }
    async payment({ params, view, session, request, response }) {
        const DATA = request.post();
        if (session.get('username')) {

            let orders = await Database.from('orders').where({
                Order_ID: DATA.Order_ID,
                Order_Whose: session.get('User_ID'),
                Order_Status: 'accept'
            });
            if (orders.length > 0) {

                const Payment_Receipt = request.file('Payment_Receipt', {
                    types: ['image'],
                    size: '2mb'
                })


                await Payment_Receipt.moveAll(Helpers.publicPath('assets/fileuploads/receipts/' + session.get('User_ID')), (file) => {
                    return {
                        name: session.get('User_ID') + "_" + Encryption.encrypt(file.fileName) + "." + `${file.subtype}`
                    }
                })

                if (Payment_Receipt.movedAll()) {
                    let payment_id = await Database.table('payments').insert({
                        Order_ID: DATA.Order_ID,
                        Payment_Urgent: DATA.Payment_Urgent,
                        Payment_Message: DATA.Payment_Message,
                        Payment_Bank: DATA.Payment_Bank,
                        Payment_Time: DATA.Payment_Time,
                        Payment_Date: DATA.Payment_Date,
                        Payment_Amount: DATA.Payment_Amount,
                        Payment_Receipt: Payment_Receipt['_files'][0].fileName,
                        Payment_Whose: session.get('User_ID'),
                        Payment_Status: '0'



                    });
                    if (payment_id) {
                        let paymentup = await Database.table('orders').where('Order_ID', DATA.Order_ID).update({
                            Order_Payment: payment_id
                        });
                        if (paymentup) {
                            session.flash({ success: 'แจ้งชำระเงินสำเร็จ กรุณารอเจ้าหน้าที่ตรวจสอบ ' })
                            return response.redirect('/history');
                        } else {
                            session.flash({ error: 'แจ้งชำระเงินไม่สำเร็จ กรุณาติดต่อเจ้าหน้าที่' })
                            return response.redirect('/history');
                        }
                    } else {
                        session.flash({ error: 'แจ้งชำระเงินไม่สำเร็จ กรุณาติดต่อเจ้าหน้าที่' })
                        return response.redirect('/history');
                    }

                } else {

                    session.flash({ error: 'การอัพโหลด ใบเสร็จโอนเงินมีปัญหา กรุณาตรวจสอบไฟล์' })
                    return response.redirect('/history');
                }

            } else {
                session.flash({ error: 'ไม่มีออเดอร์นี้อยู่ กรุณาตรวจสอบ' })
                return response.redirect('/history');
            }

        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
            })
        }

    }
    async accept_recive({ params, view, session, request, response }) {

        let order_id = params.order_id;

        if (session.get('username')) {
            let orders = await Database.from('orders').where({
                Order_ID: order_id
            })
            let dealer = await Database.from('users').where({
                User_ID: orders[0].Order_ToWho
            })
            //return parseInt(orders[0].Order_Total)-(parseInt(orders[0].Order_SumEvent)*parseInt(10)/parseFloat(100));

            let update = await Database.table('orders').update({
                Order_Status: 'success'
            }).where({
                Order_ID: order_id
            });

            if (update) {
                let balance = await Database.table('balances').insert({
                    Balance_Get: parseInt(orders[0].Order_SumEvent) * parseInt(10) / parseFloat(100),
                    Order_ID: order_id
                });
                if (balance) {
                    let wallet = await Database.table('users').update({
                        User_Wallet: parseInt(dealer[0].User_Wallet) + parseInt(orders[0].Order_Total) - (parseInt(orders[0].Order_SumEvent) * parseInt(10) / parseFloat(100))
                    }).where({
                        User_ID: orders[0].Order_ToWho
                    });
                    if (wallet) {
                        session.flash({ success: 'แจ้งได้รับของเรียบร้อยแล้ว ขอบคุณที่ใช้บริการค่ะ' })
                        return response.redirect('back');
                    } else {
                        session.flash({ error: 'ไม่สามารถกดรับของได้ กรุณาติดต่อเจ้าหน้าที่' })
                        return response.redirect('back');
                    }
                } else {
                    session.flash({ error: 'กรุณาแจ้งเจ้าหน้าที่ รหัสความผิดพลาด #101' })
                    return response.redirect('back');
                }
            } else {
                session.flash({ error: 'ไม่สามารถกดรับของได้ กรุณาติดต่อเจ้าหน้าที่เพื่อหาสาเหตุ' })
                return response.redirect('back');
            }


        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
            })
        }

    }
    async reject_recive({ params, view, session, request, response }) {

        let order_id = params.order_id;

        if (session.get('username')) {
            let orders = await Database.from('orders').where({
                Order_ID: order_id
            })

            let update = await Database.table('orders').update({
                Order_Status: 'reject_recive'
            }).where({
                Order_ID: order_id
            });

            if (update) {
                session.flash({ success: 'ดำเนินรายการสำเร็จ กรุณารอการติดต่อจากผู้รับหิ้วสินค้า' })
                return response.redirect('back');
            } else {
                session.flash({ error: 'ไม่สามารถทำรายการได้' })
                return response.redirect('back');
            }


        } else {
            return view.render('users/login', {
                error: "  กรุณาล็อกอินเข้าสู่ระบบ ",
                carts: session.get('cart'),
                sum_product: session.get('sum_product'),
                sum_event: session.get('sum_event'),
            })
        }

    }
}


module.exports = UserController
