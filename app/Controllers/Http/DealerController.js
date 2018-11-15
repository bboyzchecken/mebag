'use strict'
const Database = use("Database");
const Hash = use('Hash');
const Helpers = use('Helpers')
const md5 = use('md5');
const Encryption = use('Encryption');
const fs = use('fs');
class DealerController {
    
    async index({ view, response, session }) {
        if (session.get('dealername')) {
            return response.redirect("/dealer/dashboard");
        } else {
            return view.render('dealers/login');
        }
    }

    async login({ request, response, view, session }) {
        let GETDATA = request.post();
        const users = await Database.from('users').where({
            'User_Email': GETDATA.email,
            'User_Permission': 1
        });



        if (users != 0) {
            const password = await Hash.verify(GETDATA.password, users[0].User_Password);
            if (password) {

                session.put('dealername', users[0].User_Email);
                session.put('Dealer_ID', users[0].User_ID);
                return response.redirect("/dealer/dashboard");

            } else {
                return view.render('dealers/login', { error: " รหัสผ่านไม่ถูกต้อง กรุณาตรวจสอบ" })
            }

        } else {
            return view.render('dealers/login', { error: " โปรดตรวจสอบบัญชีผู้ใช้งานของท่าน " })
        }

    }

    async dashboard({ view, session }) {
        if (session.get('dealername')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('Dealer_ID')
            });
            return view.render('dealers/dashboard', { users: users })
        } else {
            return view.render('dealers/login', { error: "  กรุณาล็อกอินเข้าสู่ระบบ " })
        }
    }

    async account({ view, session }) {
        if (session.get('dealername')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('Dealer_ID')
            });
            return view.render('dealers/account', { users: users })
        } else {
            return view.render('dealers/login', { error: "  กรุณาล็อกอินเข้าสู่ระบบ " })
        }
    }


    async edit_intro({ view, session, request, response }) {
        const GETDATA = request.post();
        if (session.get('dealername')) {
            let postId = await Database.table("users").where('User_ID', session.get('Dealer_ID')).update({
                User_Intro: GETDATA.User_Intro
            });
            if (postId) {
                return response.redirect("/dealer/account");
            } else {
                return view.render('dealers/account', { error: "  แก้ไขแนะนำตัวเองไม่สำเร็จ " })
            }
        } else {
            return view.render('dealers/login', { error: "  กรุณาล็อกอินเข้าสู่ระบบ " })
        }
    }



    async bank({ view, session }) {
        if (session.get('dealername')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('Dealer_ID')
            });
            return view.render('dealers/bank', { users: users })
        } else {
            return view.render('dealers/login', { error: "  กรุณาล็อกอินเข้าสู่ระบบ " })
        }
    }

    async event({ view, session }) {
        if (session.get('dealername')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('Dealer_ID')
            });
            const events = await Database.from('events').where({
                'Event_Whose': session.get('Dealer_ID')
            }).orderBy('Event_ID', 'desc');
            return view.render('dealers/event', { users: users, events: events })
        } else {
            return view.render('dealers/login', { error: "  กรุณาล็อกอินเข้าสู่ระบบ " })
        }
    }
    async event_create({ view, session }) {


        if (session.get('dealername')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('Dealer_ID')
            });
            return view.render('dealers/create_event', { users: users })
        } else {
            return view.render('dealers/login', { error: "  กรุณาล็อกอินเข้าสู่ระบบ " })
        }
    }

    async add_event({ request, response, view, session }) {
        const Event_Image = request.file('attachments', {
            types: ['image'],
            size: '20mb'
        })

        await Event_Image.moveAll(Helpers.publicPath('assets/fileuploads/events'), (file) => {
            return {
                name: session.get('Dealer_ID') + "_" + Encryption.encrypt(file.fileName) + "." + `${file.subtype}`
            }
        })

        // return Event_Image['_files'].length;

        if (!Event_Image.movedAll()) {
            return Event_Image.errors()
        }
        let GETDATA = request.post();
        let postId = await Database.table("events").insert({
            Event_Name: GETDATA.Event_Name,
            Event_Place: GETDATA.Event_Place,
            Event_Start: GETDATA.Event_Start,
            Event_End: GETDATA.Event_End,
            Event_Type: GETDATA.Event_Type,
            Event_Price: GETDATA.Event_Price,
            Event_TransportPrice: GETDATA.Event_TransportPrice,
            Event_OtherTransportRate: GETDATA.Event_OtherTransportRate,
            Event_Detail: GETDATA.Event_Detail,
            Event_Whose: session.get('Dealer_ID'),
            Event_CoverImage: Event_Image['_files'][0].fileName,
        });


        if (postId) {
            for (let i = 0; i < Event_Image['_files'].length; i++) {
                await Database.table("event_images").insert({
                    Event_ID: postId,
                    Img_FileName: Event_Image['_files'][i].fileName,
                    Img_FilePath: Event_Image['_files'][i].tmpPath
                });
            }
            return response.redirect("/dealer/event");
        } else {
            return view.render('dealers/create_event', { users: users, error: "ไม่สามารถสร้าง Event ได้" })
        }
    }

    async event_detail({ params, view, session, request }) {
        const event_id = await params.event_id;

        if (session.get('dealername')) {
            const users = await Database.from('users').where({
                'User_ID': session.get('Dealer_ID')
            });

            const event_detail = await Database.from('events').where({
                'Event_ID': event_id
            });

            const event_image = await Database.from('event_images').where({
                'Event_ID': event_id
            });

            const products = await Database.from('products').where({
                'Event_ID': event_id
            });

            return view.render('dealers/event_detail', {
                users: users,
                events: event_detail,
                images: event_image,
                products: products,
                event_id: event_id
            })
        } else {
            return view.render('dealers/login', { error: "  กรุณาล็อกอินเข้าสู่ระบบ " })
        }
    }

    async delete_event({ params, response, view }) {
        const event_id = await params.event_id;

        const event_image = await Database.from('event_images').where({
            'Event_ID': event_id
        });

        for (let i = 0; i < event_image.length; i++) {
            fs.unlink(Helpers.publicPath('assets/fileuploads/events/')+event_image[i].Img_FileName)         
        }


        const affectedRows = await Database
            .table('events')
            .where('events.Event_ID', event_id)
            .delete();

        const img_s = await Database.table('event_images').where('Event_ID', event_id).delete();

        if (affectedRows) {
            if (img_s) {
                return response.redirect("/dealer/event");
            }
            return view.render('dealers/event', { users: users, events: events, error: "ไม่สามารถลบรูป ได้โปรดลองใหม่อีกครั้ง" })
        } else {
            return view.render('dealers/event', { users: users, events: events, error: "ไม่สามารถลบ Event ได้โปรดลองใหม่อีกครั้ง" })
        }
    }

    async event_edit({ params, view, session }) {
        const event_id = await params.event_id;
        const users = await Database.from('users').where({
            'User_ID': session.get('Dealer_ID')
        });

        const event_detail = await Database.from('events').where({
            'Event_ID': event_id
        });

        return view.render('dealers/event_edit', {
            users: users,
            events: event_detail
        })
    }
    
    async edit_event({ request, view, session, response }) {
        const Event_Image = request.file('attachments', {
            types: ['image'],
            size: '20mb'
        });
        let GETDATA = request.post();
        const users = await Database.from('users').where({
            'User_ID': session.get('Dealer_ID')
        });
        if (Event_Image) {

            await Event_Image.moveAll(Helpers.publicPath('assets/fileuploads/events'), (file) => {
                return {
                    name: session.get('Dealer_ID') + "_" + Encryption.encrypt(file.fileName) + "." + `${file.subtype}`
                }
            })


            if (!Event_Image.movedAll()) {
                return Event_Image.errors()
            }



            let postId = await Database.table("events").where('Event_ID', GETDATA.Event_ID).update({
                Event_Name: GETDATA.Event_Name,
                Event_Place: GETDATA.Event_Place,
                Event_Start: GETDATA.Event_Start,
                Event_End: GETDATA.Event_End,
                Event_Type: GETDATA.Event_Type,
                Event_Price: GETDATA.Event_Price,
                Event_TransportPrice: GETDATA.Event_TransportPrice,
                Event_OtherTransportRate: GETDATA.Event_OtherTransportRate,
                Event_Detail: GETDATA.Event_Detail,
            });

            if (postId) {
                for (let i = 0; i < Event_Image['_files'].length; i++) {
                    await Database.table("event_images").insert({
                        Event_ID:  GETDATA.Event_ID,
                        Img_FileName: Event_Image['_files'][i].fileName,
                        Img_FilePath: Event_Image['_files'][i].tmpPath
                    });
                }
                return response.redirect("/dealer/event");
            } else {
                return view.render('dealers/event/edit', { users: users, error: "ไม่สามารถแก้ไข Event ได้" })
            }
        } else {
            let postId = await Database.table("events").where('Event_ID', GETDATA.Event_ID).update({
                Event_Name: GETDATA.Event_Name,
                Event_Place: GETDATA.Event_Place,
                Event_Start: GETDATA.Event_Start,
                Event_End: GETDATA.Event_End,
                Event_Type: GETDATA.Event_Type,
                Event_Price: GETDATA.Event_Price,
                Event_TransportPrice: GETDATA.Event_TransportPrice,
                Event_OtherTransportRate: GETDATA.Event_OtherTransportRate,
                Event_Detail: GETDATA.Event_Detail,
            });
            return response.redirect("/dealer/event");
        }

    }

    async product_select({ view, session, response, params }) {
        const event_id = await params.event_id;

        const users = await Database.from('users').where({
            'User_ID': session.get('Dealer_ID')
        });

        const products = await Database.from('products').where({
            'Event_ID': event_id
        }).orderBy('Product_ID', 'desc');

        return view.render('dealers/product', {
            users: users,
            products: products,
            event_id: event_id
        })



    }

    async product_create({ view, session, response, params }) {
        const event_id = await params.event_id;
        const users = await Database.from('users').where({
            'User_ID': session.get('Dealer_ID')
        });


        const products = await Database.from('products').where({
            'Event_ID': event_id
        });
        return view.render('dealers/create_product', {
            users: users,
            products: products,
            event_id: event_id
        })
    }

    async add_product({ view, session, response, request }) {
        let GETDATA = request.post();
        let postId = await Database.table("products").insert({
            Product_Name: GETDATA.Product_Name,
            Product_Type: GETDATA.Product_Type,
            Product_Price: GETDATA.Product_Price,
            Event_ID: GETDATA.Event_ID
        });
        return response.redirect("/dealer/product_event_" + GETDATA.Event_ID);
    }

    async product_edit({ view, session, response, params }) {
        const product_id = await params.product_id;
        const users = await Database.from('users').where({
            'User_ID': session.get('Dealer_ID')
        });


        const products = await Database.from('products').where({
            'Product_ID': product_id
        });
        return view.render('dealers/edit_product', {
            users: users,
            products: products,
        })
    }

    async edit_product({ view, session, response, request }) {
        let GETDATA = request.post();
        let postId = await Database.table("products").where('Product_ID', GETDATA.Product_ID).update({
            Product_Name: GETDATA.Product_Name,
            Product_Type: GETDATA.Product_Type,
            Product_Price: GETDATA.Product_Price,
        });
        return response.redirect("/dealer/product_event_" + GETDATA.Event_ID);
    }

    async delete_product({ view, params, response }) {
        const product_id = await params.product_id;
        const products = await Database.from('products').where({
            'Product_ID': product_id
        });
        let postId = await Database.table("products").where('Product_ID', product_id).delete();

        return response.redirect("/dealer/product_event_" + products[0].Event_ID);
    }
}

module.exports = DealerController
