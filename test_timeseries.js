import redis from 'k6/x/redis';

const client = new redis.Client({
    addr: 'localhost:6379',
    password: '',
    db: 0,
  });

  export function setup() {
    console.log('writing testing 10,000 points');

    const info = client.Info()
    console.log(JSON.stringify(info));
  }


export default function () {
    console.log(`test...`);
  }