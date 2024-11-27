import { check, sleep } from "k6";
import http from "k6/http";

export let options = {
  stages: [
    { duration: "20s", target: 5 },
    { duration: "20s", target: 5 },
    { duration: "20s", target: 0 },
  ],
  thresholds: {
    "http_req_duration": ["p(95)<500"], // Allow 95% of requests to take less than 500ms
  },
};

// Discard response bodies globally
export const discardResponseBodies = true;

// Get a random integer between `min` and `max`
function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

// Main test function
export default function () {
    // Perform initial GET request
    let res = http.get("https://bloodpressurecicd.azurewebsites.net/", { responseType: "text" });
  
    // Check if GET request was successful
    check(res, { "status is 200": (r) => r.status === 200 });

     // Verify specific title is on the page
    check(res, {
    "correct title in response": (r) => r.body.includes("<title>Blood Pressure Calculator</title>"),
    });
  
    // Generate random values for the form fields
    const systolic = getRandomInt(70, 190);
    const diastolic = getRandomInt(40, 100);
  
    // Log the values being submitted by the VU
    console.log(`VU ${__VU} submitting: Systolic=${systolic}, Diastolic=${diastolic}`);
  
    // Simulate form submission
    res = res.submitForm({
      fields: {
        systolic: systolic.toString(),   // Random value for systolic (top number)
        diastolic: diastolic.toString(), // Random value for diastolic (bottom number)
        commit: "Calculate",
    },
    });

    // Check if form submission was successful
    check(res, { "is status 200": (r) => r.status === 200 });

    // Add a 3-second pause to simulate a user "thinking" before the next request
    sleep(3);
}