import { ajax } from "discourse/lib/ajax";
import { withPluginApi } from "discourse/lib/plugin-api";
import { popupAjaxError } from "discourse/lib/ajax-error";

function fetchPaymentPointer() {
  return ajax("/web-monetization/pointer.json").catch((error) => {
    if (error) {
      popupAjaxError(error);
    } else {
      console.error("no good")
      // bootbox.alert(I18n.t("poll.error_while_fetching_voters"));
    }
  });
}

function initializeWebMonetization(api) {
  console.log("initializeWebMonetization");
  fetchPaymentPointer().then((result) => {
    console.log(result)
    const node = document.createElement("meta");
    node.id = "web-monetization";
    node.name = "monetization";
    node.content = result.pointer;
    console.log("Appending node:")
    console.log(node)
    document.querySelector("head").appendChild(node);
  })

  // api.decorateCookedElement(
  //   (elem) => {
  //     console.logdecorateCookedElement");
  //   },
  //   { id: "web-monetization-meta", onlyStream: true, afterAdopt: true }
  // );
}

export default {
  name: "web-monetization",

  initialize() {
    withPluginApi("0.8.31", initializeWebMonetization);
  },
};
