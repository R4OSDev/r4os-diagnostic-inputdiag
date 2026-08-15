const r4os = @import("r4os");

const DiagApi = struct {
    sys: r4os.r4sys.Context,
    desk: r4os.r4desk.Context,
    draw: r4os.r4draw.Context,

    fn init(r4_app: *r4os.App) ?DiagApi {
        return .{
            .sys = r4_app.system(),
            .desk = r4_app.desktop() orelse return null,
            .draw = r4_app.drawing() orelse return null,
        };
    }
};

pub fn r4_app_main(r4_app: *r4os.App) i32 {
    var ctx = DiagApi.init(r4_app) orelse return r4os.abi.err_no_group;
    var mouse: r4os.abi.Mouse = undefined;
    ctx.desk.mouseState(&mouse);

    ctx.sys.println("INPUTD");
    ctx.sys.print("screen: ");
    ctx.sys.printU64(ctx.draw.screenWidth());
    ctx.sys.write("x");
    ctx.sys.printU64(ctx.draw.screenHeight());
    ctx.sys.write("\r\n");

    ctx.sys.print("mouse present=");
    ctx.sys.printU64(mouse.present);
    ctx.sys.write(" x=");
    ctx.sys.printI32(mouse.x);
    ctx.sys.write(" y=");
    ctx.sys.printI32(mouse.y);
    ctx.sys.write(" buttons=");
    ctx.sys.printU64(mouse.buttons);
    ctx.sys.write(" packets=");
    ctx.sys.printU64(mouse.packets);
    ctx.sys.write("\r\n");

    ctx.sys.println("keys for 100 ticks, Q exits:");
    const deadline = ctx.sys.ticks() + 100;
    while (ctx.sys.ticks() < deadline) {
        const key = ctx.desk.readKey();
        if (key == 0) {
            ctx.sys.taskYield();
            continue;
        }
        ctx.sys.print("key ");
        ctx.sys.printHexU32(key);
        ctx.sys.write("\r\n");
        if (key == 'q' or key == 'Q') break;
    }

    return 0;
}
