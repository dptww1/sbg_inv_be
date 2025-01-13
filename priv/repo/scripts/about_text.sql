TRUNCATE about, faqs;

INSERT INTO about (body_text, inserted_at, updated_at) VALUES (
'<p>This web site lets you track your inventory of figures for Games Workshop''s
 <i>Middle Earth Strategy Battle Game</i>
 and compare it against the requirements of the official published scenarios.
 Want to know the biggest (or smallest) scenarios?  Which scenarios have YouTube video replays?
 How many Warg Riders do you need if you want to play all of the scenarios?  How far along your
 collection is if you want to play <i>The Last Alliance</i>? You can find the answers here!</p>

 <p>You''ll need to sign up for an account to track your inventory.  This will also give you ability to rate
 scenarios, to help your fellow gamers find an overlooked gem. When you sign up, the site will use a cookie to
 remember who you are, but nothing other than that will be done with your information. I hate spam, too.</p>

 <p>If you note any incorrect information, find bugs, or have ideas for improvement, I''d love to hear from you at
 <a target="_new" href="mailto:dave@davetownsend.org">dave@davetownsend.org</a>.</p>

 <p>Financial contributions are not required but are always appreciated.  (In a perfect world I would raise enough
 money to work on this full-time. But the world ain''t perfect.)  You can PayPal me a donation at the above email
 address. I have no Patreon set up at the moment, but if you''d like to contribute that way, let me know.</p>

 <p>I hope you find this useful!</p>

 <p>Dave Townsend / <a target="_new" href="mailto:dave@davetownsend.org">dave@davetownsend.org</a>',
 CURRENT_TIMESTAMP,
 CURRENT_TIMESTAMP
);

INSERT INTO faqs (about_id, question, answer, sort_order, inserted_at, updated_at) VALUES
(
  (SELECT id from about LIMIT 1),
  'How about including <i>White Dwarf</i> scenarios?',
  'There are a number of reasons why I haven''t included them:
  <ol><li>I don''t have all the issues, so data collection is a problem</li>
  <li>the issue numbers differ between the US and UK editions, so which do I use?</li>
  <li>the time to enter the data isn''t trivial</li>
  <li>the scenario list is already probably too long, so adding more just compounds the problem</li>
  <li>I''m not convinced that many of the magazine scenarios are all that good.</li></ol>
  None of these is prohibitive on it''s own, but put together the results just don''t seem
  worth the level of effort to me.  C''mon, you haven''t played <i>all</i> the scenarios
  already here, have you? <tt>:^)</tt>',
  1,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
(
  (SELECT id from about LIMIT 1),
  'The <a href="https://www.sbginventory.com/#/scenarios/260">Battle of the Pelennor Fields scenario</a> says I need
   48 Morannon Orcs. But the Army Lists says we need 48 of <i>each type</i> of Morannon Orc rather than 48
   <i>total</i>.  What gives?',
  'In cases where the exact build isn''t specified, the site has no way of knowing exactly what build(s) you will
  eventually use.  You could use 48 orcs with spear, or 48 orcs with shield, or 24 of each, ... or any of a myriad
  of various combinations.  So the site punts and says the maximum is required.  This isn''t ideal.
  But it not obvious how to fix it, at least not without a lot more database horsepower, especially as the number
  of scenarios grows (see previous FAQ).',
  2,
  CURRENT_TIMESTAMP,
  CURRENT_TIMESTAMP
),
(
   (SELECT id from about LIMIT 1),
   'How about adding conversions (Elendil on horse, etc)?',
   'For my own sanity I''m trying to keep the database to just GW official figures. Otherwise it''s difficult to
   draw the line on what to include and what to exclude.  Personal conversions?  Medbury miniatures?',
   3,
   CURRENT_TIMESTAMP,
   CURRENT_TIMESTAMP
 );
