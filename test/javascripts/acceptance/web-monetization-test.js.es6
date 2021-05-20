import { acceptance } from "discourse/tests/helpers/qunit-helpers";

acceptance("WebMonetization", { loggedIn: true });

test("WebMonetization works", async assert => {
  await visit("/admin/plugins/web-monetization");

  assert.ok(false, "it shows the WebMonetization button");
});
