console.log('starting function');

export function handle(e: Object, ctx: Object, cb: Function) {
    console.log('processing event %j', e);
    cb(null, { hello: 'world' });
}