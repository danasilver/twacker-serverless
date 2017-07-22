import { Context, Callback } from 'aws-lambda';

console.log('starting function');

export function handle(e: any, ctx: Context, cb: Callback) {
    console.log('processing event %j', e);
    cb(null, { hello: 'world' });
}
