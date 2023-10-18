const recordMetadata = {
    title: 'title',
    location: 'location',
    company: 'company',
    snippet: 'description',
    salary: 'salary'
};
const ENDPOINT ='https://jooble.org/api/2a3be2fb-3555-410e-924b-8e2c964de9d3'
const POST_METHOD = 'POST'; //POST method
const CONTENT_TYPE = 'application/json; charset=utf-8';
export default function fetchDataHelper({ amountOfRecords }) {
    /* The global fetch() method starts the process of fetching a resource from the network,
     returning a promise which is fulfilled once the response is available.
    */
    return fetch(ENDPOINT, {
        method: POST_METHOD,
        headers: {
            'Content-Type': CONTENT_TYPE,
        },
        body: JSON.stringify({
            amountOfRecords,
            recordMetadata,
        }),
    }).then((response) => response.json());
}