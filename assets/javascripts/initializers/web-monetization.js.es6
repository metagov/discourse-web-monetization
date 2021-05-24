import { ajax } from "discourse/lib/ajax";
import { withPluginApi } from "discourse/lib/plugin-api";

function fetchPaymentPointer(topic_id) {
  const data = { topic_id };
  return ajax("/web-monetization/pointer.json", { data }).catch((error) => {
    console.error("Error fetching web monetization pointer");
    if (error) {
      console.error(error);
    }
  });
}

function initializeWebMonetization(api) {
  api.onAppEvent("page:topic-loaded", (topic) => {
    if (!topic || topic.isPrivateMessage) {
      return;
    }
    fetchPaymentPointer(topic.id).then((result) => {
      console.log(result);
      const node = document.createElement("meta");
      node.id = "web-monetization";
      node.name = "monetization";
      node.content = result.pointer;
      console.log("Appending node:");
      console.log(node);
      document.querySelector("head").appendChild(node);
    });
  });
}

export default {
  name: "web-monetization",

  initialize() {
    withPluginApi("0.8.31", initializeWebMonetization);
  },
};
