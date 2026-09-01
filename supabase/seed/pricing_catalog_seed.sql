-- Demo Pricing Catalog Seed Data (201 Items)
-- Sourced from greenscape_pro_pricing_catalog.csv
TRUNCATE TABLE pricing_items CASCADE;
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-001',
      'Site Preparation',
      'Mobilization',
      'Site Mobilization & Setup',
      'Base charge for crew mobilization, equipment delivery, staging, and site protection prior to starting work.',
      'project',
      850,
      1,
      1,
      1,
      ARRAY['mobilization', 'site setup', 'getting started', 'crew setup', 'job setup']::text[],
      false,
      false,
      true,
      'Confirm site access and whether equipment can be staged on-property or requires street parking.',
      'Charged on nearly every project as a base line item; select once per proposal regardless of scope size.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-002',
      'Site Preparation',
      'Grading',
      'Rough Grading',
      'Initial grading of the yard to establish base elevations and slope prior to hardscape or turf installation.',
      'sqft',
      2.25,
      500,
      2000,
      8000,
      ARRAY['rough grading', 'leveling the yard', 'grading', 'yard leveling', 'dirt work']::text[],
      true,
      false,
      true,
      'How many square feet of the yard need rough grading?',
      'High confidence when notes mention grading, leveling, or uneven/sloped yard as a starting condition.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-003',
      'Site Preparation',
      'Grading',
      'Fine Grading & Prep',
      'Final grading pass to prepare a smooth, compacted base immediately before installing turf, pavers, or planting.',
      'sqft',
      1.1,
      500,
      2000,
      8000,
      ARRAY['fine grading', 'base prep', 'final grading', 'surface prep']::text[],
      true,
      false,
      false,
      'How many square feet require fine grading before installation?',
      'Medium confidence; often bundled implicitly with turf or paver notes rather than mentioned directly.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-004',
      'Site Preparation',
      'Soil',
      'Soil Import & Amendment',
      'Delivery and incorporation of imported topsoil or amended soil for planting areas or fill.',
      'cubic_yard',
      68,
      5,
      20,
      100,
      ARRAY['import soil', 'topsoil delivery', 'soil amendment', 'fill dirt', 'compost amendment']::text[],
      true,
      false,
      true,
      'How many cubic yards of soil are needed, and is this for fill or planting beds?',
      'Medium confidence; select when notes mention poor existing soil, fill needed, or planting bed prep at scale.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-005',
      'Site Preparation',
      'Demolition',
      'Existing Landscape Demo & Haul-Off',
      'Removal of existing grass, plants, mulch, or loose landscape material and haul-off from the property.',
      'sqft',
      3.75,
      200,
      1200,
      6000,
      ARRAY['yard demo', 'tear out old landscaping', 'remove existing yard', 'landscape removal', 'clear the yard']::text[],
      true,
      false,
      true,
      'How many square feet of existing landscaping need to be removed?',
      'High confidence when notes mention tearing out, removing, or replacing an existing yard or landscape bed.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-006',
      'Site Preparation',
      'Demolition',
      'Concrete Demo & Removal',
      'Breaking, removal, and haul-off of existing concrete slabs, walkways, or patios.',
      'sqft',
      6.5,
      100,
      600,
      3000,
      ARRAY['concrete demo', 'remove old concrete', 'break out concrete', 'concrete removal', 'demo the slab']::text[],
      true,
      false,
      true,
      'How many square feet of existing concrete need to be demolished and removed?',
      'High confidence when notes explicitly mention removing, breaking out, or replacing existing concrete.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-007',
      'Site Preparation',
      'Demolition',
      'Tree/Stump Removal',
      'Removal of an existing tree and grinding or extraction of its stump and root ball.',
      'each',
      475,
      1,
      2,
      6,
      ARRAY['tree removal', 'stump removal', 'stump grinding', 'remove a tree', 'take out a tree']::text[],
      false,
      false,
      true,
      'How many trees or stumps need to be removed, and what is the approximate trunk diameter?',
      'High confidence when notes mention removing a specific tree or stump before new landscaping.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-008',
      'Site Preparation',
      'Disposal',
      'Debris Haul-Off (Dumpster)',
      'On-site dumpster rental and disposal of construction and landscape debris generated during the project.',
      'each',
      625,
      1,
      2,
      5,
      ARRAY['dumpster', 'debris removal', 'haul away debris', 'trash removal', 'job site cleanup']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; typically added automatically on demolition-heavy projects rather than requested by name.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-009',
      'Site Preparation',
      'Utilities',
      'Utility Locate & Verification',
      'Coordination of underground utility locates (electric, gas, irrigation, cable) prior to excavation.',
      'project',
      325,
      1,
      1,
      1,
      ARRAY['call before you dig', 'utility locate', '811 locate', 'check for utility lines', 'locate underground lines']::text[],
      false,
      false,
      true,
      'Are there any known underground utilities, irrigation lines, or a septic system in the work area?',
      'High confidence when notes mention digging, trenching, drainage, or wall footings near property lines.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-010',
      'Concrete',
      'Patio',
      'Concrete Patio Installation - Standard Broom Finish',
      'Installation of a broom-finished concrete patio slab, including forming, reinforcement, and pour.',
      'sqft',
      9.75,
      200,
      700,
      2500,
      ARRAY['concrete patio', 'plain concrete patio', 'broom finish patio', 'basic concrete patio', 'poured patio']::text[],
      true,
      false,
      true,
      'How many square feet of concrete patio should be installed?',
      'High confidence when notes mention a plain or basic concrete patio without a decorative finish.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-011',
      'Concrete',
      'Patio',
      'Concrete Patio Installation - Stamped',
      'Installation of a stamped and colored decorative concrete patio, including pattern and release-color finish.',
      'sqft',
      14.5,
      200,
      700,
      2500,
      ARRAY['stamped concrete patio', 'decorative concrete patio', 'stamped concrete', 'patterned concrete patio']::text[],
      true,
      true,
      true,
      'How many square feet of stamped concrete, and which pattern/color is preferred?',
      'High confidence when notes explicitly mention stamped, patterned, or decorative concrete.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-012',
      'Concrete',
      'Patio',
      'Concrete Patio Installation - Exposed Aggregate',
      'Installation of an exposed-aggregate finish concrete patio for a textured, non-slip surface.',
      'sqft',
      13.25,
      200,
      700,
      2500,
      ARRAY['exposed aggregate patio', 'aggregate concrete', 'textured concrete patio', 'pebble finish patio']::text[],
      true,
      true,
      true,
      'How many square feet of exposed aggregate patio should be installed?',
      'High confidence when notes explicitly mention exposed aggregate or a textured pebble-look finish.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-013',
      'Concrete',
      'Walkway',
      'Concrete Walkway',
      'Installation of a poured concrete walkway or pathway connecting outdoor areas.',
      'sqft',
      11,
      40,
      150,
      600,
      ARRAY['concrete walkway', 'concrete path', 'concrete sidewalk', 'walkway']::text[],
      true,
      false,
      true,
      'How many square feet (or linear feet and width) of walkway are needed?',
      'High confidence when notes mention a walkway or path without specifying paver or gravel material.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-014',
      'Concrete',
      'Driveway',
      'Concrete Driveway Extension',
      'Installation of additional poured concrete driveway or parking area adjoining the existing driveway.',
      'sqft',
      12.75,
      200,
      600,
      2000,
      ARRAY['driveway extension', 'extra parking pad', 'concrete driveway', 'widen the driveway', 'parking pad']::text[],
      true,
      false,
      true,
      'How many square feet of driveway extension are needed, and where does it connect to the existing driveway?',
      'Medium confidence; select when notes mention additional parking or driveway widening.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-015',
      'Concrete',
      'Steps',
      'Concrete Steps',
      'Construction of poured concrete steps connecting two elevation changes, priced per step.',
      'each',
      285,
      2,
      4,
      10,
      ARRAY['concrete steps', 'concrete stairs', 'steps down to the yard', 'stairs']::text[],
      true,
      false,
      true,
      'How many steps are needed and what is the total rise in height?',
      'Medium confidence; select when notes mention steps or stairs without specifying paver or stone material.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-016',
      'Concrete',
      'Curbing',
      'Concrete Curbing',
      'Installation of poured concrete curbing to edge planting beds, turf areas, or driveways.',
      'linear_ft',
      18.5,
      20,
      80,
      300,
      ARRAY['concrete curbing', 'curbing', 'bed edging', 'mow curb', 'concrete border']::text[],
      true,
      false,
      false,
      'How many linear feet of curbing are needed?',
      'Medium confidence; select when notes mention a mow curb or permanent concrete edge between areas.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-017',
      'Concrete',
      'Finish Upgrade',
      'Colored Concrete Upgrade',
      'Integral or dyed color upgrade added to a standard concrete pour.',
      'sqft',
      2.25,
      200,
      700,
      2500,
      ARRAY['colored concrete', 'tinted concrete', 'concrete color upgrade', 'dyed concrete']::text[],
      false,
      true,
      false,
      'Which concrete color is preferred for this upgrade?',
      'Medium confidence; select as an add-on when notes mention colored or tinted concrete alongside a base patio item.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-018',
      'Concrete',
      'Sealing',
      'Concrete Sealing',
      'Application of a penetrating or film-forming sealer to protect and enhance a finished concrete surface.',
      'sqft',
      1.35,
      200,
      700,
      2500,
      ARRAY['seal the concrete', 'concrete sealer', 'concrete sealing', 'protective coating']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; usually bundled with a new pour rather than requested as a standalone item.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-019',
      'Concrete',
      'Cutting',
      'Concrete Saw Cutting / Control Joints',
      'Saw cutting of control joints or decorative scoring patterns into a concrete slab.',
      'linear_ft',
      4.5,
      20,
      100,
      400,
      ARRAY['saw cutting', 'control joints', 'score lines', 'expansion joints']::text[],
      true,
      false,
      false,
      'How many linear feet of saw cutting or control joints are needed?',
      'Low confidence as a standalone request; usually included with a new pour rather than mentioned separately.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-020',
      'Concrete',
      'Repair',
      'Concrete Repair & Patch',
      'Patching and repair of cracked, spalled, or settled sections of existing concrete.',
      'sqft',
      9,
      10,
      40,
      150,
      ARRAY['concrete repair', 'patch the concrete', 'fix cracked concrete', 'concrete patch']::text[],
      true,
      false,
      true,
      'How many square feet of concrete need repair, and what is the visible damage (cracks, settling, spalling)?',
      'High confidence when notes mention repairing, patching, or fixing existing concrete rather than replacing it.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-021',
      'Concrete',
      'Structural',
      'Concrete Footing (for structures)',
      'Poured concrete footings sized to support pergolas, walls, or other structural elements.',
      'cubic_yard',
      215,
      1,
      3,
      12,
      ARRAY['footings', 'concrete footing', 'structural footing', 'post footings']::text[],
      true,
      false,
      true,
      'How many footings are needed, and what structure will they support?',
      'Medium confidence; typically bundled with a pergola or wall item rather than requested by name.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-022',
      'Concrete',
      'Structural',
      'Reinforced Concrete Slab (Outdoor Kitchen/Structure Base)',
      'Reinforced concrete slab built to support the weight and utility routing of an outdoor kitchen or similar structure.',
      'sqft',
      10.75,
      100,
      300,
      900,
      ARRAY['kitchen slab', 'concrete base for kitchen', 'reinforced slab', 'outdoor kitchen foundation']::text[],
      true,
      false,
      true,
      'How many square feet of reinforced slab are needed for the structure''s footprint?',
      'Medium confidence; select when notes describe an outdoor kitchen or structure base rather than a walkable patio.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-023',
      'Pavers',
      'Patio',
      'Standard Paver Patio Installation',
      'Installation of a standard concrete paver patio over a compacted base, including edge restraint.',
      'sqft',
      16.25,
      150,
      600,
      2500,
      ARRAY['paver patio', 'pavers', 'patio pavers', 'paver installation', 'brick pavers', 'backyard pavers']::text[],
      true,
      true,
      true,
      'How many square feet of paver patio, and is there a preferred paver style or color?',
      'High confidence when notes mention pavers, paver patio, or brick-style patio without a premium material called out.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-024',
      'Pavers',
      'Patio',
      'Premium Paver Patio Installation',
      'Installation of a premium paver product (textured, tumbled, or multi-tone) over a compacted base.',
      'sqft',
      22.75,
      150,
      600,
      2500,
      ARRAY['premium pavers', 'high-end paver patio', 'designer pavers', 'tumbled pavers']::text[],
      true,
      true,
      true,
      'How many square feet, and which premium paver line is preferred?',
      'Medium confidence; select when notes emphasize a high-end or designer paver look.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-025',
      'Pavers',
      'Patio',
      'Large-Format Paver Installation',
      'Installation of large-format (18x18 or larger) concrete or porcelain pavers for a modern patio look.',
      'sqft',
      26.5,
      150,
      600,
      2500,
      ARRAY['large format pavers', 'big paver tiles', 'modern pavers', 'large paver slabs']::text[],
      true,
      true,
      true,
      'How many square feet of large-format pavers, and concrete or porcelain?',
      'High confidence when notes mention large-format, modern slab, or oversized paver tiles.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-026',
      'Pavers',
      'Patio',
      'Travertine Paver Installation',
      'Installation of natural travertine pavers, a popular premium finish for Phoenix pool decks and patios.',
      'sqft',
      28,
      150,
      500,
      1800,
      ARRAY['travertine pavers', 'travertine patio', 'natural stone pavers', 'travertine deck']::text[],
      true,
      true,
      true,
      'How many square feet of travertine, and is this for a patio or pool deck?',
      'High confidence when notes specifically mention travertine.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-027',
      'Pavers',
      'Patio',
      'Permeable Paver Installation',
      'Installation of permeable interlocking pavers over an open-graded base to manage stormwater on-site.',
      'sqft',
      19.5,
      150,
      600,
      2000,
      ARRAY['permeable pavers', 'drainage pavers', 'porous pavers', 'eco pavers']::text[],
      true,
      true,
      true,
      'How many square feet of permeable pavers, and is this being installed to address a drainage issue?',
      'Medium confidence; select when notes mention drainage-friendly or permeable paving specifically.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-028',
      'Pavers',
      'Accent',
      'Paver Border/Soldier Course',
      'Installation of a contrasting soldier-course border framing a paver or turf area.',
      'linear_ft',
      14,
      20,
      60,
      200,
      ARRAY['paver border', 'soldier course', 'paver edge band', 'border pavers']::text[],
      true,
      true,
      false,
      'How many linear feet of border are needed, and should it contrast with the field pavers?',
      'Medium confidence; usually bundled with a paver patio or turf item as an accent detail.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-029',
      'Pavers',
      'Walkway',
      'Paver Walkway',
      'Installation of a paver walkway or path connecting outdoor spaces.',
      'sqft',
      17.5,
      40,
      150,
      600,
      ARRAY['paver walkway', 'paver path', 'walkway pavers', 'stone path']::text[],
      true,
      true,
      false,
      'How many square feet (or linear feet and width) of paver walkway are needed?',
      'High confidence when notes mention a paver or stone walkway/path.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-030',
      'Pavers',
      'Steps',
      'Paver Steps',
      'Construction of paver-clad steps connecting two elevation changes in the yard.',
      'each',
      325,
      2,
      4,
      10,
      ARRAY['paver steps', 'paver stairs', 'stone steps']::text[],
      true,
      true,
      true,
      'How many steps are needed and what is the total rise in height?',
      'Medium confidence; select when notes mention steps alongside a paver patio or hillside yard.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-031',
      'Pavers',
      'Pool Deck',
      'Paver Pool Deck Installation',
      'Installation of paver decking around an existing pool, including edge restraint at the pool coping.',
      'sqft',
      24,
      150,
      500,
      1800,
      ARRAY['pavers around the pool', 'pool deck pavers', 'pool paver deck', 'pool surround pavers']::text[],
      true,
      true,
      true,
      'How many square feet of pool deck need pavers, and is the pool coping being replaced?',
      'High confidence when notes mention pavers around a pool or a pool deck specifically.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-032',
      'Pavers',
      'Demolition',
      'Paver Demolition & Removal',
      'Removal and haul-off of an existing paver patio, walkway, or deck.',
      'sqft',
      5.5,
      100,
      400,
      2000,
      ARRAY['remove old pavers', 'paver demo', 'paver removal', 'tear out pavers']::text[],
      true,
      false,
      true,
      'How many square feet of existing pavers need to be removed?',
      'High confidence when notes mention removing or replacing an existing paver surface.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-033',
      'Pavers',
      'Repair',
      'Paver Repair (Settled/Cracked Sections)',
      'Lifting, re-leveling, or replacing settled, sunken, or cracked paver sections.',
      'sqft',
      12,
      10,
      50,
      200,
      ARRAY['paver repair', 'fix sunken pavers', 'releveling pavers', 'cracked paver fix']::text[],
      true,
      false,
      true,
      'How many square feet of pavers need repair, and are they sinking, shifting, or cracked?',
      'High confidence when notes describe an existing paver problem rather than a new installation.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-034',
      'Pavers',
      'Maintenance',
      'Paver Sealing',
      'Application of a protective sealer to enhance color and resist staining on an existing paver surface.',
      'sqft',
      2.1,
      150,
      600,
      2500,
      ARRAY['seal the pavers', 'paver sealer', 'paver sealing', 'protect the pavers']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; usually bundled with a new paver install or requested as maintenance on an existing patio.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-035',
      'Pavers',
      'Maintenance',
      'Paver Sand Joint Stabilization (Polymeric Sand)',
      'Re-sanding paver joints with polymeric sand to reduce weed growth and shifting.',
      'sqft',
      1.85,
      150,
      600,
      2500,
      ARRAY['polymeric sand', 'resand the pavers', 'joint sand', 'paver joint stabilization']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; typically bundled with new installs or requested for weed control on existing pavers.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-036',
      'Pavers',
      'Accent',
      'Paver Edge Restraint Installation',
      'Installation of rigid edge restraint to lock paver fields in place and prevent lateral shifting.',
      'linear_ft',
      6.75,
      20,
      80,
      300,
      ARRAY['edge restraint', 'paver edging', 'restraint edging']::text[],
      false,
      false,
      false,
      NULL,
      'Low confidence as a standalone request; typically bundled automatically with a paver installation item.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-037',
      'Pavers',
      'Driveway',
      'Paver Driveway Installation',
      'Installation of a structural-rated paver driveway including a compacted aggregate base.',
      'sqft',
      21.5,
      200,
      600,
      2000,
      ARRAY['paver driveway', 'brick driveway', 'driveway pavers']::text[],
      true,
      true,
      true,
      'How many square feet of driveway need pavers, and will vehicles be parked or driven on it regularly?',
      'High confidence when notes mention a paver or brick driveway specifically.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-038',
      'Walls & Masonry',
      'Retaining Wall',
      'Retaining Wall - Standard Block',
      'Construction of a segmental block retaining wall up to 4 feet in height, including base prep and drainage gravel.',
      'linear_ft',
      85,
      20,
      80,
      300,
      ARRAY['retaining wall', 'block wall', 'yard retaining wall', 'grade wall']::text[],
      true,
      true,
      true,
      'How many linear feet of retaining wall are required, and what is the average height?',
      'High confidence when notes mention a retaining wall or holding back a slope/grade change under 4 feet.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-039',
      'Walls & Masonry',
      'Retaining Wall',
      'Retaining Wall - Engineered/Tall (>4ft)',
      'Construction of an engineered retaining wall over 4 feet in height, including engineering review and reinforced base.',
      'linear_ft',
      145,
      20,
      60,
      250,
      ARRAY['tall retaining wall', 'engineered wall', 'big retaining wall', 'high retaining wall']::text[],
      true,
      true,
      true,
      'How many linear feet, and does the wall height exceed 4 feet at any point (may require engineering)?',
      'High confidence when notes mention a tall wall, engineered wall, or significant elevation change.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-040',
      'Walls & Masonry',
      'Seat Wall',
      'Seat Wall',
      'Construction of a low masonry seat wall used for extra seating or to define a patio edge.',
      'linear_ft',
      95,
      10,
      40,
      150,
      ARRAY['seat wall', 'sitting wall', 'bench wall', 'low wall for seating']::text[],
      true,
      true,
      false,
      'How many linear feet of seat wall are needed?',
      'Medium confidence; ''wall'' alone is ambiguous between retaining, seat, and decorative walls without more context.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-041',
      'Walls & Masonry',
      'Decorative Wall',
      'Decorative Wall / Privacy Wall',
      'Construction of a freestanding decorative or privacy wall not intended to retain soil.',
      'linear_ft',
      110,
      10,
      50,
      200,
      ARRAY['privacy wall', 'decorative wall', 'screening wall', 'freestanding wall']::text[],
      true,
      true,
      true,
      'How many linear feet and what height is needed, and is this for privacy or purely decorative purposes?',
      'Medium confidence; ''wall'' alone is ambiguous between retaining, seat, and decorative walls without more context.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-042',
      'Walls & Masonry',
      'Finish',
      'Stone Veneer Wall Facing',
      'Application of natural or manufactured stone veneer to the face of an existing or new wall.',
      'sqft',
      32,
      20,
      100,
      400,
      ARRAY['stone veneer', 'stone facing', 'faced wall', 'stone cladding']::text[],
      true,
      true,
      false,
      'How many square feet of wall face need stone veneer, and which stone style is preferred?',
      'High confidence when notes mention stone veneer or facing an existing wall in stone.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-043',
      'Walls & Masonry',
      'Wall Cap',
      'Wall Cap - Natural Stone',
      'Installation of a natural stone cap along the top of a retaining, seat, or decorative wall.',
      'linear_ft',
      28,
      10,
      60,
      250,
      ARRAY['stone wall cap', 'natural stone cap', 'wall coping']::text[],
      false,
      true,
      false,
      NULL,
      'Medium confidence; typically bundled with a wall item once material style is chosen.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-044',
      'Walls & Masonry',
      'Wall Cap',
      'Wall Cap - Precast Concrete',
      'Installation of a precast concrete cap along the top of a retaining, seat, or decorative wall.',
      'linear_ft',
      18,
      10,
      60,
      250,
      ARRAY['concrete wall cap', 'precast cap', 'standard wall cap']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; typically bundled with a wall item as the default cap option.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-045',
      'Walls & Masonry',
      'Column',
      'Column/Pilaster - Masonry',
      'Construction of a freestanding or wall-integrated masonry column or pilaster, often for gate or fence posts.',
      'each',
      875,
      1,
      2,
      6,
      ARRAY['column', 'pilaster', 'masonry pillar', 'gate column', 'entry column']::text[],
      false,
      true,
      true,
      'How many columns are needed and what is the intended height?',
      'Medium confidence; usually mentioned alongside a gate, fence, or entry feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-046',
      'Walls & Masonry',
      'Lighting',
      'Wall Lighting Niche',
      'Recessed lighting niche built into a masonry wall for accent illumination.',
      'each',
      210,
      1,
      3,
      10,
      ARRAY['wall niche light', 'recessed wall light', 'lighted niche']::text[],
      false,
      false,
      true,
      'How many lighting niches are needed along the wall?',
      'Low confidence as a standalone request; usually bundled with a wall and lighting package.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-047',
      'Walls & Masonry',
      'Demolition',
      'Wall Demolition & Removal',
      'Demolition and haul-off of an existing masonry, block, or concrete wall.',
      'linear_ft',
      22,
      10,
      60,
      250,
      ARRAY['remove old wall', 'wall demo', 'tear down the wall', 'wall removal']::text[],
      true,
      false,
      true,
      'How many linear feet of existing wall need to be removed, and what is it built from?',
      'High confidence when notes mention removing or replacing an existing wall.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-048',
      'Walls & Masonry',
      'Retaining Wall',
      'Boulder Wall / Natural Stone Wall',
      'Construction of a stacked boulder or natural stone retaining wall for a more organic, desert-style look.',
      'linear_ft',
      120,
      15,
      50,
      200,
      ARRAY['boulder wall', 'stacked stone wall', 'natural stone retaining wall', 'rock wall']::text[],
      true,
      true,
      true,
      'How many linear feet of boulder wall, and what is the average height?',
      'High confidence when notes mention boulders, stacked stone, or a natural rock retaining wall.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-049',
      'Walls & Masonry',
      'Drainage',
      'Wall Drainage Backfill (Gravel + Drain Pipe)',
      'Installation of gravel backfill and perforated drain pipe behind a retaining wall to relieve hydrostatic pressure.',
      'linear_ft',
      16,
      20,
      80,
      300,
      ARRAY['wall drainage', 'backfill gravel', 'wall drain pipe', 'retaining wall drainage']::text[],
      false,
      false,
      true,
      NULL,
      'Medium confidence; typically bundled automatically with any retaining wall over 2 feet in height.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-050',
      'Pergolas & Shade',
      'Aluminum Pergola',
      'Aluminum Pergola 10x12',
      'Installed 10x12 powder-coated aluminum pergola with standard louvered or lattice roof panel, including footings.',
      'each',
      8950,
      1,
      1,
      2,
      ARRAY['pergola', 'covered patio', 'covered seating area', 'shade structure', 'outdoor cover', 'aluminum pergola', '10x12 pergola', 'big covered sitting area']::text[],
      true,
      true,
      true,
      'Confirm the desired footprint (10x12) and roof style — louvered or fixed lattice?',
      'Medium confidence for generic ''covered sitting area'' language; high confidence once dimensions or ''aluminum'' are specified.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-051',
      'Pergolas & Shade',
      'Aluminum Pergola',
      'Aluminum Pergola 12x14',
      'Installed 12x14 powder-coated aluminum pergola with standard louvered or lattice roof panel, including footings.',
      'each',
      12750,
      1,
      1,
      2,
      ARRAY['pergola', 'covered patio', 'covered seating area', 'shade structure', 'aluminum pergola', '12x14 pergola', 'big covered sitting area']::text[],
      true,
      true,
      true,
      'Confirm the desired footprint (12x14) and roof style — louvered or fixed lattice?',
      'Medium confidence for generic shade-structure language; high confidence when dimensions match 12x14.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-052',
      'Pergolas & Shade',
      'Aluminum Pergola',
      'Aluminum Pergola 14x16',
      'Installed 14x16 powder-coated aluminum pergola with standard louvered or lattice roof panel, including footings.',
      'each',
      16200,
      1,
      1,
      2,
      ARRAY['pergola', 'large covered patio', 'big shade structure', 'aluminum pergola', '14x16 pergola']::text[],
      true,
      true,
      true,
      'Confirm the desired footprint (14x16) and roof style — louvered or fixed lattice?',
      'Medium confidence for generic large-pergola language; high confidence when dimensions match 14x16.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-053',
      'Pergolas & Shade',
      'Aluminum Pergola',
      'Custom Aluminum Pergola (Oversized/Custom Footprint)',
      'Engineered aluminum pergola built to a custom footprint beyond standard sizes, including footings and structural review.',
      'each',
      22500,
      1,
      1,
      1,
      ARRAY['custom pergola', 'oversized pergola', 'custom shade structure', 'large custom cover']::text[],
      true,
      true,
      true,
      'What are the exact dimensions and roofline needed for the custom pergola?',
      'Medium confidence; select when requested dimensions exceed standard 14x16 sizing.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-054',
      'Pergolas & Shade',
      'Wood Pergola',
      'Wood Pergola - Standard',
      'Installed standard cedar or redwood pergola, open-lattice style, including footings.',
      'each',
      9800,
      1,
      1,
      2,
      ARRAY['wood pergola', 'cedar pergola', 'wooden shade structure', 'open pergola']::text[],
      true,
      true,
      true,
      'Confirm the desired footprint and whether cedar or redwood is preferred.',
      'High confidence when notes specifically mention wood or cedar as the pergola material.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-055',
      'Pergolas & Shade',
      'Wood Pergola',
      'Cedar Wood Pergola - Premium',
      'Installed premium cedar pergola with upgraded beam sizing and decorative rafter tails.',
      'each',
      14600,
      1,
      1,
      2,
      ARRAY['premium wood pergola', 'high-end cedar pergola', 'custom wood pergola']::text[],
      true,
      true,
      true,
      'Confirm the desired footprint and any decorative beam or rafter-tail preferences.',
      'Medium confidence; select when notes emphasize a premium or high-end wood structure.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-056',
      'Pergolas & Shade',
      'Upgrade',
      'Pergola Roof Upgrade - Louvered/Motorized',
      'Upgrade of a standard pergola roof to a motorized, adjustable louvered roof system.',
      'each',
      6400,
      1,
      1,
      1,
      ARRAY['louvered roof', 'motorized pergola roof', 'adjustable roof', 'opening roof pergola']::text[],
      false,
      false,
      false,
      NULL,
      'High confidence when notes mention an adjustable, louvered, or motorized pergola roof.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-057',
      'Pergolas & Shade',
      'Upgrade',
      'Pergola Privacy Screen Panel',
      'Installation of a privacy screen panel on one side of an existing or new pergola structure.',
      'each',
      625,
      1,
      2,
      6,
      ARRAY['privacy screen', 'pergola side panel', 'wind screen', 'privacy panel']::text[],
      false,
      true,
      false,
      'How many sides of the pergola need privacy screening?',
      'Medium confidence; select when notes mention wind or privacy screening for a shade structure.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-058',
      'Pergolas & Shade',
      'Upgrade',
      'Pergola Lighting Package',
      'Installation of integrated string or recessed lighting within the pergola structure.',
      'each',
      1450,
      1,
      1,
      1,
      ARRAY['pergola lights', 'string lights', 'pergola lighting', 'lighted pergola']::text[],
      false,
      false,
      false,
      NULL,
      'High confidence when notes mention lighting within or around a covered patio/pergola.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-059',
      'Pergolas & Shade',
      'Upgrade',
      'Pergola Fan Installation',
      'Installation of an outdoor-rated ceiling fan mounted to the pergola structure.',
      'each',
      875,
      1,
      1,
      3,
      ARRAY['pergola fan', 'outdoor ceiling fan', 'patio fan']::text[],
      false,
      true,
      true,
      'How many fans are needed, and is 220V/circuit access already available nearby?',
      'High confidence when notes mention a fan for the covered patio or pergola.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-060',
      'Pergolas & Shade',
      'Shade Sail',
      'Shade Sail Installation',
      'Installation of a tensioned fabric shade sail anchored to posts or existing structures.',
      'each',
      1650,
      1,
      2,
      4,
      ARRAY['shade sail', 'sail shade', 'canopy sail', 'fabric shade']::text[],
      true,
      true,
      true,
      'What size and shape shade sail is needed, and what will it anchor to?',
      'High confidence when notes specifically mention a shade sail rather than a pergola or ramada.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-061',
      'Pergolas & Shade',
      'Ramada',
      'Ramada / Freestanding Covered Structure',
      'Construction of a freestanding ramada with a solid roof, typically used over outdoor kitchens or large gathering areas.',
      'each',
      18500,
      1,
      1,
      1,
      ARRAY['ramada', 'covered structure', 'solid roof cover', 'outdoor kitchen cover']::text[],
      true,
      true,
      true,
      'What footprint and roof material (tile, standing seam metal, etc.) are needed for the ramada?',
      'Medium confidence; select for solid-roof cover requests, distinct from an open-slat pergola.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-062',
      'Outdoor Kitchens',
      'Cabinetry',
      'Outdoor Kitchen Base Cabinet',
      'Installation of weather-rated stainless steel or masonry base cabinetry for an outdoor kitchen island.',
      'linear_ft',
      625,
      4,
      12,
      30,
      ARRAY['kitchen cabinet', 'outdoor cabinets', 'kitchen island base', 'base cabinet']::text[],
      true,
      true,
      true,
      'How many linear feet of base cabinetry are needed for the kitchen island layout?',
      'High confidence when notes mention an outdoor kitchen island or cabinetry base.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-063',
      'Outdoor Kitchens',
      'Countertop',
      'Outdoor Kitchen Countertop - Granite',
      'Fabrication and installation of granite countertop for an outdoor kitchen island.',
      'linear_ft',
      145,
      4,
      12,
      30,
      ARRAY['granite countertop', 'outdoor kitchen countertop', 'granite counter']::text[],
      true,
      false,
      false,
      'How many linear feet of granite countertop are needed?',
      'High confidence when notes specifically mention granite as the countertop material.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-064',
      'Outdoor Kitchens',
      'Countertop',
      'Outdoor Kitchen Countertop - Concrete',
      'Fabrication and installation of a poured or precast concrete countertop for an outdoor kitchen island.',
      'linear_ft',
      110,
      4,
      12,
      30,
      ARRAY['concrete countertop', 'poured concrete counter']::text[],
      true,
      false,
      false,
      'How many linear feet of concrete countertop are needed?',
      'High confidence when notes specifically mention concrete as the countertop material.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-065',
      'Outdoor Kitchens',
      'Countertop',
      'Outdoor Kitchen Countertop - Tile',
      'Installation of a tiled countertop surface for an outdoor kitchen island.',
      'linear_ft',
      85,
      4,
      12,
      30,
      ARRAY['tile countertop', 'tiled counter']::text[],
      true,
      true,
      false,
      'How many linear feet of tile countertop are needed, and which tile is preferred?',
      'High confidence when notes specifically mention tile as the countertop material.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-066',
      'Outdoor Kitchens',
      'Appliance',
      'Built-In Grill',
      'Supply and installation of a built-in gas grill within the outdoor kitchen island.',
      'each',
      3450,
      1,
      1,
      2,
      ARRAY['built-in grill', 'outdoor grill', 'bbq grill', 'island grill']::text[],
      false,
      true,
      true,
      'Which grill brand/size is preferred, and is a natural gas line available nearby?',
      'High confidence when notes mention a built-in grill or BBQ as part of an outdoor kitchen.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-067',
      'Outdoor Kitchens',
      'Appliance',
      'Built-In Grill - Premium',
      'Supply and installation of a premium high-BTU built-in gas grill with additional burners and searing station.',
      'each',
      6800,
      1,
      1,
      2,
      ARRAY['premium grill', 'high-end bbq', 'professional grill']::text[],
      false,
      true,
      true,
      'Which premium grill brand/size is preferred, and is a natural gas line available nearby?',
      'Medium confidence; select when notes emphasize a high-end or professional-grade grill.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-068',
      'Outdoor Kitchens',
      'Appliance',
      'Outdoor Refrigerator',
      'Supply and installation of a weather-rated outdoor refrigerator within the kitchen island.',
      'each',
      2150,
      1,
      1,
      2,
      ARRAY['outdoor fridge', 'outdoor refrigerator', 'beverage fridge']::text[],
      false,
      true,
      true,
      'Is a dedicated 110V outlet already available at the fridge location?',
      'High confidence when notes mention a fridge or beverage cooler in the outdoor kitchen.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-069',
      'Outdoor Kitchens',
      'Plumbing',
      'Outdoor Sink & Faucet',
      'Supply and installation of a stainless steel sink and faucet with hot/cold supply and drain routing.',
      'each',
      1375,
      1,
      1,
      2,
      ARRAY['outdoor sink', 'kitchen sink', 'wet bar sink']::text[],
      false,
      true,
      true,
      'Is a water supply and drain line already available near the kitchen location?',
      'High confidence when notes mention a sink as part of the outdoor kitchen.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-070',
      'Outdoor Kitchens',
      'Appliance',
      'Side Burner',
      'Supply and installation of a side burner unit within the outdoor kitchen island.',
      'each',
      1050,
      1,
      1,
      2,
      ARRAY['side burner', 'extra burner', 'sear burner']::text[],
      false,
      true,
      true,
      'How many side burners are needed?',
      'Medium confidence; select when notes mention an extra burner in addition to the main grill.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-071',
      'Outdoor Kitchens',
      'Storage',
      'Storage Drawer Unit',
      'Installation of a weather-rated stainless steel storage drawer unit within the kitchen island.',
      'each',
      685,
      1,
      2,
      6,
      ARRAY['storage drawers', 'kitchen drawers', 'stainless drawers']::text[],
      false,
      false,
      false,
      'How many drawer units are needed in the island layout?',
      'Medium confidence; select when notes mention storage or drawers as part of the kitchen build.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-072',
      'Outdoor Kitchens',
      'Storage',
      'Trash/Recycling Pullout',
      'Installation of a pull-out trash and recycling bin unit within the kitchen island cabinetry.',
      'each',
      475,
      1,
      1,
      2,
      ARRAY['trash pullout', 'recycling bin', 'garbage drawer']::text[],
      false,
      false,
      false,
      NULL,
      'Low confidence as a standalone request; typically requested alongside full cabinetry.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-073',
      'Outdoor Kitchens',
      'Finish',
      'Outdoor Kitchen Backsplash',
      'Installation of a tile or stone backsplash on the vertical surface behind the countertop.',
      'sqft',
      28,
      10,
      30,
      100,
      ARRAY['kitchen backsplash', 'tile backsplash', 'island backsplash']::text[],
      true,
      true,
      false,
      'How many square feet of backsplash are needed, and which tile/stone is preferred?',
      'Medium confidence; select when notes mention a decorative wall finish behind the counter.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-074',
      'Outdoor Kitchens',
      'Lighting',
      'Outdoor Kitchen Lighting Package',
      'Installation of task and accent lighting integrated into the kitchen island and surrounding area.',
      'each',
      950,
      1,
      1,
      1,
      ARRAY['kitchen lighting', 'island lighting', 'task lighting']::text[],
      false,
      false,
      true,
      NULL,
      'Medium confidence; select when notes mention lighting specifically at the cooking/prep area.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-075',
      'Outdoor Kitchens',
      'Seating',
      'Bar Seating Overhang / Raised Bar Top',
      'Extension of the countertop to create a raised bar overhang for stool seating.',
      'linear_ft',
      175,
      4,
      8,
      20,
      ARRAY['bar seating', 'bar overhang', 'raised bar top', 'counter seating']::text[],
      true,
      false,
      false,
      'How many linear feet of bar seating overhang are needed?',
      'Medium confidence; select when notes mention seating at the island or a bar-height counter.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-076',
      'Outdoor Kitchens',
      'Appliance',
      'Pizza Oven - Built-In',
      'Supply and installation of a built-in wood-fired or gas pizza oven within the outdoor kitchen structure.',
      'each',
      7900,
      1,
      1,
      1,
      ARRAY['pizza oven', 'wood-fired oven', 'built-in oven']::text[],
      false,
      true,
      true,
      'Is a wood-fired or gas pizza oven preferred, and where should it sit relative to the kitchen island?',
      'High confidence when notes specifically mention a pizza oven.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-077',
      'Fire Features',
      'Fire Pit',
      'Gas Fire Pit - Standard',
      'Installation of a standard prefabricated gas fire pit with burner and gas line connection.',
      'each',
      3250,
      1,
      1,
      2,
      ARRAY['gas fire pit', 'fire pit', 'propane fire pit', 'outdoor fire pit']::text[],
      false,
      true,
      true,
      'Is this fire pit natural gas or propane, and is a gas line already available nearby?',
      'Medium confidence for generic ''fire pit'' notes; high confidence when gas is specified.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-078',
      'Fire Features',
      'Fire Pit',
      'Gas Fire Pit - Custom Masonry',
      'Construction of a custom masonry gas fire pit built to match patio hardscape materials.',
      'each',
      5900,
      1,
      1,
      2,
      ARRAY['custom fire pit', 'masonry fire pit', 'built-in fire pit', 'matching fire pit']::text[],
      true,
      true,
      true,
      'What size and shape fire pit is needed, and should it match the surrounding paver/wall material?',
      'Medium confidence; select when notes mention a custom or built-in fire pit matching the hardscape.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-079',
      'Fire Features',
      'Fire Pit',
      'Wood-Burning Fire Pit',
      'Construction of a wood-burning fire pit, typically masonry or metal ring style.',
      'each',
      2450,
      1,
      1,
      2,
      ARRAY['wood burning fire pit', 'wood fire pit', 'campfire pit']::text[],
      false,
      true,
      true,
      'Confirm local fire code allows a wood-burning pit at this location.',
      'High confidence when notes specifically mention wood-burning rather than gas.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-080',
      'Fire Features',
      'Fire Bowl',
      'Fire Bowl',
      'Installation of a freestanding decorative gas fire bowl.',
      'each',
      1875,
      1,
      1,
      3,
      ARRAY['fire bowl', 'fire pot', 'decorative fire bowl']::text[],
      false,
      true,
      true,
      'Is a gas line available near the desired fire bowl location?',
      'High confidence when notes specifically mention a fire bowl rather than a full fire pit.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-081',
      'Fire Features',
      'Linear Fire',
      'Linear Fire Feature',
      'Installation of a linear gas fire trough or feature, often integrated into a wall or water feature.',
      'linear_ft',
      425,
      4,
      8,
      20,
      ARRAY['linear fire feature', 'fire trough', 'modern fire line', 'linear fire pit']::text[],
      true,
      true,
      true,
      'How many linear feet of fire feature are needed, and will it be freestanding or built into a wall?',
      'High confidence when notes mention a linear or modern fire feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-082',
      'Fire Features',
      'Upgrade',
      'Fire Pit Burner Upgrade',
      'Upgrade of a fire pit burner to a larger BTU output or electronic ignition system.',
      'each',
      685,
      1,
      1,
      1,
      ARRAY['burner upgrade', 'bigger flame', 'electronic ignition']::text[],
      false,
      false,
      false,
      NULL,
      'Low confidence as a standalone request; typically bundled with a new fire pit order.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-083',
      'Fire Features',
      'Upgrade',
      'Fire Glass Upgrade',
      'Upgrade from standard lava rock to reflective fire glass media in a gas fire feature.',
      'each',
      175,
      1,
      1,
      3,
      ARRAY['fire glass', 'glass rocks', 'fire pit glass upgrade']::text[],
      false,
      true,
      false,
      'Which fire glass color is preferred?',
      'High confidence when notes specifically mention fire glass.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-084',
      'Fire Features',
      'Seating',
      'Fire Pit Seating Surround',
      'Construction of a low masonry seating surround built around a fire pit.',
      'linear_ft',
      145,
      10,
      20,
      40,
      ARRAY['fire pit seating', 'seating around the fire pit', 'fire pit surround']::text[],
      true,
      true,
      false,
      'How many linear feet of seating surround are needed around the fire pit?',
      'Medium confidence; select when notes mention seating built directly around a fire feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-085',
      'Fire Features',
      'Gas Line',
      'Gas Line Run (Fire Feature)',
      'Extension of a gas line from the existing meter or stub-out to a new fire feature location.',
      'linear_ft',
      32,
      10,
      30,
      100,
      ARRAY['gas line', 'run gas to the fire pit', 'gas line extension']::text[],
      true,
      false,
      true,
      'How far is the fire feature from the existing gas meter or stub-out?',
      'High confidence when notes mention needing gas run to a new fire feature location.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-086',
      'Fire Features',
      'Controls',
      'Fire Feature Ignition/Control System',
      'Installation of an electronic ignition and remote or app-based control system for a gas fire feature.',
      'each',
      825,
      1,
      1,
      1,
      ARRAY['remote ignition', 'fire pit remote', 'app-controlled fire pit', 'electronic ignition system']::text[],
      false,
      false,
      true,
      NULL,
      'Medium confidence; select when notes mention remote or app control for a fire feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-087',
      'Water Features',
      'Pondless',
      'Pondless Water Feature - Small',
      'Construction of a small pondless recirculating water feature with basin, pump, and rock work.',
      'each',
      6500,
      1,
      1,
      1,
      ARRAY['small water feature', 'pondless waterfall', 'recirculating fountain', 'backyard waterfall']::text[],
      true,
      true,
      true,
      'What is the desired size/footprint of the water feature, and where is the nearest power source?',
      'Medium confidence; select for a smaller-scale water feature request without pool integration.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-088',
      'Water Features',
      'Pondless',
      'Pondless Water Feature - Large',
      'Construction of a large pondless recirculating water feature with expanded basin, multiple pumps, and rock work.',
      'each',
      12800,
      1,
      1,
      1,
      ARRAY['large water feature', 'big waterfall', 'backyard waterfall feature']::text[],
      true,
      true,
      true,
      'What is the desired size/footprint of the water feature, and where is the nearest power source?',
      'Medium confidence; select when notes describe a larger or more elaborate waterfall feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-089',
      'Water Features',
      'Pool',
      'Custom Pool-Adjacent Water Feature',
      'Construction of a custom water feature integrated with an existing pool, such as a raised spa spillway or rock waterfall.',
      'each',
      18500,
      1,
      1,
      1,
      ARRAY['pool water feature', 'pool waterfall', 'spa spillway', 'pool rock feature']::text[],
      true,
      true,
      true,
      'What type of pool-integrated feature is desired, and can you share the pool''s existing equipment setup?',
      'High confidence when notes mention a water feature connected to or integrated with an existing pool.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-090',
      'Water Features',
      'Fountain',
      'Fountain - Freestanding',
      'Supply and installation of a freestanding decorative fountain with recirculating pump.',
      'each',
      2950,
      1,
      1,
      2,
      ARRAY['fountain', 'freestanding fountain', 'decorative fountain', 'yard fountain']::text[],
      false,
      true,
      true,
      'Which fountain style is preferred, and where should it be placed?',
      'High confidence when notes mention a fountain as a standalone feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-091',
      'Water Features',
      'Fountain',
      'Wall-Mounted Water Feature',
      'Installation of a wall-mounted water feature with integrated spillway and recirculating pump.',
      'each',
      3750,
      1,
      1,
      2,
      ARRAY['wall fountain', 'wall water feature', 'spillway wall']::text[],
      false,
      true,
      true,
      'Which wall is the feature being mounted to, and is it a new or existing wall?',
      'High confidence when notes mention a wall-mounted fountain or spillway.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-092',
      'Water Features',
      'Lighting',
      'Water Feature Lighting',
      'Installation of submersible or accent lighting to illuminate an existing or new water feature.',
      'each',
      425,
      1,
      2,
      6,
      ARRAY['water feature lighting', 'waterfall lights', 'underwater lighting']::text[],
      false,
      false,
      true,
      'How many lights are needed for the water feature?',
      'Medium confidence; select when notes mention lighting the water feature specifically.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-093',
      'Water Features',
      'Equipment',
      'Water Feature Pump Upgrade',
      'Upgrade of an existing water feature''s pump to increase flow rate or improve energy efficiency.',
      'each',
      650,
      1,
      1,
      1,
      ARRAY['pump upgrade', 'bigger pump', 'water feature pump']::text[],
      false,
      false,
      true,
      NULL,
      'Medium confidence; select when notes mention improving flow or replacing an existing pump.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-094',
      'Water Features',
      'Structure',
      'Spillway/Scupper Installation',
      'Installation of a spillway or scupper element feeding a pool, spa, or water feature basin.',
      'each',
      875,
      1,
      2,
      4,
      ARRAY['spillway', 'scupper', 'water spout feature']::text[],
      false,
      true,
      true,
      'How many spillways/scuppers are needed, and where do they feed into?',
      'Medium confidence; select when notes mention a spillway or scupper specifically.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-095',
      'Water Features',
      'Service',
      'Water Feature Repair/Service',
      'Diagnostic and repair service call for an existing water feature (pump, leak, or plumbing issue).',
      'project',
      450,
      1,
      1,
      1,
      ARRAY['fix the water feature', 'water feature repair', 'waterfall not working', 'fountain service']::text[],
      false,
      false,
      true,
      'What symptom is the water feature showing (not running, leaking, low flow)?',
      'High confidence when notes describe an existing water feature that is malfunctioning.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-096',
      'Water Features',
      'Accent',
      'Bubbler Rock Feature',
      'Installation of a small bubbling rock water feature, often used near entries or planting beds.',
      'each',
      1150,
      1,
      2,
      4,
      ARRAY['bubbler rock', 'bubbling rock', 'small water feature rock']::text[],
      false,
      true,
      true,
      'How many bubbler rocks are needed, and where should they be placed?',
      'High confidence when notes specifically mention a bubbler or bubbling rock feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-097',
      'Artificial Turf',
      'Turf',
      'Artificial Turf - Standard',
      'Installation of standard-pile artificial turf over a compacted and leveled base, including infill.',
      'sqft',
      9.5,
      300,
      800,
      2500,
      ARRAY['fake grass', 'synthetic grass', 'artificial grass', 'turf', 'fake lawn', 'synthetic turf']::text[],
      true,
      true,
      true,
      'How many square feet of turf should be installed?',
      'High confidence when notes mention fake grass, synthetic grass, or turf without a premium/pet/putting qualifier.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-098',
      'Artificial Turf',
      'Turf',
      'Artificial Turf - Premium',
      'Installation of premium multi-tone, longer-pile artificial turf for a more natural appearance.',
      'sqft',
      12.75,
      300,
      800,
      2500,
      ARRAY['premium turf', 'high-end fake grass', 'natural-look turf', 'putting-style turf']::text[],
      true,
      true,
      true,
      'How many square feet of premium turf should be installed?',
      'Medium confidence; select when notes emphasize a natural or high-end turf look.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-099',
      'Artificial Turf',
      'Turf',
      'Artificial Turf - Pet-Friendly',
      'Installation of pet-friendly artificial turf with an antimicrobial backing and enhanced drainage.',
      'sqft',
      11.25,
      300,
      800,
      2500,
      ARRAY['pet turf', 'dog turf', 'pet-friendly grass', 'dog run turf']::text[],
      true,
      true,
      true,
      'How many square feet of pet-friendly turf are needed, and is this for a dedicated dog run?',
      'High confidence when notes mention pets, dogs, or a dog run alongside turf.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-100',
      'Artificial Turf',
      'Turf',
      'Artificial Turf - Putting Green',
      'Installation of specialty putting-green turf with cup and contour options for a backyard golf green.',
      'sqft',
      17.5,
      150,
      400,
      1200,
      ARRAY['putting green', 'golf green', 'backyard putting green']::text[],
      true,
      true,
      true,
      'How many square feet, and how many cups/holes are desired for the putting green?',
      'High confidence when notes specifically mention a putting green or backyard golf feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-101',
      'Artificial Turf',
      'Prep',
      'Turf Base Prep & Compaction',
      'Excavation and compaction of a proper aggregate base beneath a turf installation.',
      'sqft',
      2.1,
      300,
      800,
      2500,
      ARRAY['turf base', 'base prep for turf', 'compact the base']::text[],
      true,
      false,
      true,
      NULL,
      'Medium confidence; typically bundled automatically with any turf installation item.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-102',
      'Artificial Turf',
      'Demolition',
      'Turf Removal (Existing Synthetic)',
      'Removal and haul-off of existing worn or damaged artificial turf.',
      'sqft',
      2.75,
      300,
      800,
      2500,
      ARRAY['remove old turf', 'turf removal', 'replace the fake grass', 'tear out turf']::text[],
      true,
      false,
      true,
      'How many square feet of existing turf need to be removed?',
      'High confidence when notes mention replacing or removing existing artificial turf.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-103',
      'Artificial Turf',
      'Accent',
      'Turf Border/Edging',
      'Installation of a defined border or edge restraint around a turf area.',
      'linear_ft',
      8.5,
      30,
      100,
      400,
      ARRAY['turf edging', 'turf border', 'lawn edge']::text[],
      false,
      false,
      false,
      NULL,
      'Low confidence as a standalone request; typically bundled with a turf installation.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-104',
      'Artificial Turf',
      'Upgrade',
      'Turf Infill Upgrade (Antimicrobial/Cooling)',
      'Upgrade of standard silica infill to an antimicrobial or heat-reducing cooling infill product.',
      'sqft',
      1.65,
      300,
      800,
      2500,
      ARRAY['cooling infill', 'antimicrobial infill', 'cool turf upgrade']::text[],
      false,
      true,
      false,
      'Which infill upgrade is preferred — cooling, antimicrobial, or both?',
      'Medium confidence; select when notes mention turf getting too hot or pet odor concerns.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-105',
      'Natural Landscaping',
      'Rock',
      'Decorative Rock Installation - Standard',
      'Installation of standard decorative rock groundcover (e.g., granite chip) over landscape fabric.',
      'sqft',
      3.25,
      200,
      1000,
      5000,
      ARRAY['decorative rock', 'landscape rock', 'rock groundcover', 'granite rock']::text[],
      true,
      true,
      false,
      'How many square feet of decorative rock are needed, and which color/size is preferred?',
      'High confidence when notes mention rock, gravel groundcover, or a low-water yard finish.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-106',
      'Natural Landscaping',
      'Rock',
      'Decorative Rock Installation - Premium (Larger/Specialty)',
      'Installation of premium or larger-format decorative rock, such as river rock or specialty aggregate.',
      'sqft',
      5.75,
      200,
      1000,
      5000,
      ARRAY['river rock', 'premium rock', 'specialty rock', 'large decorative rock']::text[],
      true,
      true,
      false,
      'How many square feet, and which specialty rock product is preferred?',
      'Medium confidence; select when notes emphasize a premium or river-rock look.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-107',
      'Natural Landscaping',
      'Rock',
      'Gravel Installation - Base/Path',
      'Installation of compacted gravel for a path, base layer, or utility area.',
      'sqft',
      2.4,
      100,
      500,
      2000,
      ARRAY['gravel', 'gravel path', 'gravel base', 'crushed rock']::text[],
      true,
      false,
      false,
      'How many square feet of gravel are needed?',
      'Medium confidence; select when notes mention gravel without a decorative rock qualifier.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-108',
      'Natural Landscaping',
      'Boulders',
      'Boulder Placement - Accent',
      'Placement of a single accent boulder (under 500 lbs) within a planting bed or yard.',
      'each',
      285,
      1,
      4,
      15,
      ARRAY['accent boulder', 'small boulder', 'landscape boulder']::text[],
      false,
      false,
      true,
      'How many accent boulders are needed?',
      'Medium confidence; select when notes mention boulders as a landscape accent rather than a wall.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-109',
      'Natural Landscaping',
      'Boulders',
      'Boulder Placement - Large Feature',
      'Placement of a large feature boulder (500+ lbs) requiring machine placement.',
      'each',
      950,
      1,
      2,
      6,
      ARRAY['large boulder', 'feature rock', 'big boulder placement']::text[],
      false,
      false,
      true,
      'How many large feature boulders are needed, and is machine access available?',
      'Medium confidence; select when notes mention a large or statement boulder feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-110',
      'Natural Landscaping',
      'Edging',
      'Landscape Edging - Steel',
      'Installation of steel landscape edging to separate turf, rock, and planting bed areas.',
      'linear_ft',
      9.5,
      30,
      120,
      500,
      ARRAY['steel edging', 'metal landscape edging', 'bed edging']::text[],
      true,
      false,
      false,
      'How many linear feet of steel edging are needed?',
      'Medium confidence; select when notes mention a clean edge between rock, turf, and planting areas.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-111',
      'Natural Landscaping',
      'Edging',
      'Landscape Edging - Stone/Paver',
      'Installation of a stone or paver edge band separating turf, rock, and planting bed areas.',
      'linear_ft',
      14,
      30,
      120,
      500,
      ARRAY['stone edging', 'paver edging strip', 'decorative bed edge']::text[],
      true,
      true,
      false,
      'How many linear feet of stone/paver edging are needed?',
      'Medium confidence; select when notes mention a decorative rather than steel edge.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-112',
      'Natural Landscaping',
      'Groundcover',
      'Weed Barrier Fabric Installation',
      'Installation of woven landscape fabric beneath rock or mulch groundcover to suppress weeds.',
      'sqft',
      0.85,
      200,
      1000,
      5000,
      ARRAY['weed barrier', 'landscape fabric', 'weed fabric']::text[],
      false,
      false,
      false,
      NULL,
      'Low confidence as a standalone request; typically bundled with rock or mulch installation.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-113',
      'Natural Landscaping',
      'Mulch',
      'Mulch Installation',
      'Delivery and spreading of decorative bark or wood mulch in planting beds.',
      'cubic_yard',
      95,
      3,
      10,
      40,
      ARRAY['mulch', 'bark mulch', 'wood chips', 'mulch installation']::text[],
      true,
      true,
      false,
      'How many cubic yards of mulch are needed, and which color/type is preferred?',
      'High confidence when notes mention mulch specifically.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-114',
      'Natural Landscaping',
      'Feature',
      'Dry Creek Bed Installation',
      'Construction of a decorative dry creek bed using river rock and boulders, often used for drainage.',
      'linear_ft',
      48,
      15,
      40,
      150,
      ARRAY['dry creek bed', 'rock creek bed', 'decorative drainage channel', 'dry river bed']::text[],
      true,
      true,
      true,
      'How many linear feet of dry creek bed are needed, and is it also functioning as a drainage path?',
      'High confidence when notes mention a dry creek bed or decorative rock drainage channel.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-115',
      'Irrigation',
      'Zone',
      'New Irrigation Zone - Drip',
      'Installation of a new drip irrigation zone including valve, tubing, and emitters for a planting area.',
      'zone',
      685,
      1,
      3,
      10,
      ARRAY['drip irrigation', 'drip zone', 'new irrigation zone', 'irrigation for plants']::text[],
      true,
      false,
      true,
      'How many new drip zones are needed, and roughly how many plants will each zone cover?',
      'High confidence when notes mention drip irrigation or watering for new planting beds.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-116',
      'Irrigation',
      'Zone',
      'New Irrigation Zone - Spray/Rotor',
      'Installation of a new spray or rotor irrigation zone including valve, piping, and heads for turf areas.',
      'zone',
      825,
      1,
      2,
      8,
      ARRAY['sprinkler zone', 'spray irrigation', 'rotor heads', 'sprinkler system']::text[],
      true,
      false,
      true,
      'How many new spray/rotor zones are needed to cover the turf or lawn area?',
      'High confidence when notes mention sprinklers or spray irrigation for real turf areas.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-117',
      'Irrigation',
      'Drip',
      'Drip Irrigation Line (Per Plant Run)',
      'Extension of a drip line run with an emitter to an individual new plant.',
      'each',
      28,
      5,
      20,
      100,
      ARRAY['drip line to plants', 'emitter run', 'individual drip line']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; typically bundled with a planting item rather than requested separately.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-118',
      'Irrigation',
      'Controller',
      'Irrigation Controller - Standard',
      'Supply and installation of a standard multi-zone irrigation timer/controller.',
      'each',
      385,
      1,
      1,
      1,
      ARRAY['irrigation timer', 'sprinkler controller', 'irrigation clock']::text[],
      false,
      false,
      true,
      'How many zones does the controller need to support?',
      'Medium confidence; select when notes mention needing a new timer or controller.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-119',
      'Irrigation',
      'Controller',
      'Smart Irrigation Controller Upgrade',
      'Upgrade to a Wi-Fi enabled smart irrigation controller with weather-based scheduling.',
      'each',
      625,
      1,
      1,
      1,
      ARRAY['smart controller', 'wifi irrigation controller', 'app-controlled sprinklers']::text[],
      false,
      false,
      true,
      NULL,
      'High confidence when notes mention a smart, app-based, or Wi-Fi irrigation controller.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-120',
      'Irrigation',
      'Repair',
      'Irrigation Valve Replacement',
      'Diagnosis and replacement of a failed irrigation valve.',
      'each',
      195,
      1,
      1,
      4,
      ARRAY['valve replacement', 'broken valve', 'irrigation valve repair']::text[],
      false,
      false,
      true,
      'How many valves appear to be failing, and what symptoms are you seeing (zone not turning on/off)?',
      'High confidence when notes describe a specific broken valve or zone malfunction.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-121',
      'Irrigation',
      'Repair',
      'Irrigation Repair/Diagnostic',
      'Hourly diagnostic and repair service for irrigation system issues not covered by a flat-rate item.',
      'hour',
      135,
      1,
      2,
      6,
      ARRAY['irrigation repair', 'sprinkler not working', 'fix the sprinklers', 'irrigation troubleshooting']::text[],
      false,
      false,
      true,
      'What symptoms is the irrigation system showing?',
      'Medium confidence; used as a catch-all when the specific irrigation issue isn''t yet diagnosed.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-122',
      'Irrigation',
      'Mainline',
      'Irrigation Mainline Extension',
      'Extension of the irrigation mainline to reach a new zone or planting area.',
      'linear_ft',
      14,
      20,
      80,
      300,
      ARRAY['mainline extension', 'extend the irrigation line', 'irrigation pipe run']::text[],
      true,
      false,
      true,
      'How far does the mainline need to be extended to reach the new area?',
      'Medium confidence; typically bundled with a new irrigation zone in a distant part of the yard.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-123',
      'Irrigation',
      'Controller',
      'Rain/Freeze Sensor Installation',
      'Installation of a rain or freeze sensor to automatically suspend irrigation cycles during weather events.',
      'each',
      165,
      1,
      1,
      1,
      ARRAY['rain sensor', 'freeze sensor', 'weather sensor']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; select when notes mention water conservation or weather-based shutoff.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-124',
      'Irrigation',
      'Backflow',
      'Backflow Preventer Installation',
      'Installation of a code-required backflow prevention device on the irrigation supply line.',
      'each',
      675,
      1,
      1,
      1,
      ARRAY['backflow preventer', 'backflow device', 'anti-siphon valve']::text[],
      false,
      false,
      true,
      NULL,
      'Medium confidence; typically required by code on new irrigation systems tied into the main water line.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-125',
      'Irrigation',
      'Service',
      'Irrigation System Winterization/Startup',
      'Seasonal service to shut down or start up the irrigation system and check for leaks or damage.',
      'project',
      225,
      1,
      1,
      1,
      ARRAY['irrigation startup', 'winterize the sprinklers', 'seasonal irrigation check']::text[],
      false,
      false,
      false,
      NULL,
      'High confidence when notes mention seasonal startup, shutdown, or a general system check.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-126',
      'Drainage',
      'French Drain',
      'French Drain Installation',
      'Installation of a French drain including trenching, perforated pipe, gravel backfill, and fabric wrap.',
      'linear_ft',
      32,
      20,
      80,
      300,
      ARRAY['french drain', 'yard drainage', 'drain trench', 'water drainage line']::text[],
      true,
      false,
      true,
      'How many linear feet of French drain are needed, and where does standing water currently collect?',
      'High confidence when notes mention a French drain or a specific standing-water problem area.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-127',
      'Drainage',
      'Catch Basin',
      'Catch Basin Installation',
      'Installation of a catch basin to collect surface water and route it into the drainage system.',
      'each',
      475,
      1,
      2,
      6,
      ARRAY['catch basin', 'drain box', 'yard drain inlet']::text[],
      false,
      false,
      true,
      'How many catch basins are needed, and where should they be located?',
      'High confidence when notes mention a catch basin or a low point that collects water.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-128',
      'Drainage',
      'Channel Drain',
      'Channel Drain Installation',
      'Installation of a linear channel drain, typically at a patio edge or driveway transition, to intercept surface flow.',
      'linear_ft',
      58,
      6,
      20,
      80,
      ARRAY['channel drain', 'trench drain', 'linear drain grate']::text[],
      true,
      false,
      true,
      'How many linear feet of channel drain are needed, and where does water need to be intercepted?',
      'High confidence when notes mention a channel or trench drain at a patio or driveway edge.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-129',
      'Drainage',
      'Downspout',
      'Downspout Drainage Extension',
      'Underground extension of a roof downspout to route water away from the foundation.',
      'linear_ft',
      22,
      10,
      30,
      100,
      ARRAY['downspout extension', 'gutter drainage', 'route the downspout']::text[],
      true,
      false,
      true,
      'How many downspouts need to be extended, and roughly how far does each need to run?',
      'High confidence when notes mention downspout, gutter, or roof drainage issues.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-130',
      'Drainage',
      'Drywell',
      'Drywell Installation',
      'Installation of an underground drywell to collect and slowly disperse excess stormwater.',
      'each',
      2150,
      1,
      1,
      3,
      ARRAY['drywell', 'dry well', 'underground water storage']::text[],
      false,
      false,
      true,
      'How many drywells are needed, and what soil conditions are present on-site?',
      'Medium confidence; select for larger drainage systems where surface discharge isn''t an option.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-131',
      'Drainage',
      'Grading',
      'Grading Correction',
      'Regrading of a section of yard to correct negative slope or standing water issues.',
      'sqft',
      2.75,
      200,
      800,
      3000,
      ARRAY['fix the grading', 'regrade the yard', 'correct the slope', 'standing water fix']::text[],
      true,
      false,
      true,
      'How many square feet need regrading, and where does water currently pool?',
      'High confidence when notes describe standing water or improper slope in the yard.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-132',
      'Drainage',
      'Area Drain',
      'Area Drain Installation',
      'Installation of a point-source area drain within a patio, turf, or planting area.',
      'each',
      325,
      1,
      2,
      6,
      ARRAY['area drain', 'point drain', 'yard drain']::text[],
      false,
      false,
      true,
      'How many area drains are needed, and where should they be located?',
      'Medium confidence; select for isolated low points rather than a full French drain system.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-133',
      'Drainage',
      'Sump',
      'Sump Pump Installation',
      'Installation of a sump pump system to actively remove water from a low-lying or below-grade area.',
      'each',
      1450,
      1,
      1,
      1,
      ARRAY['sump pump', 'water pump system', 'pump out the water']::text[],
      false,
      false,
      true,
      'Is this for a below-grade area, and is electrical power available nearby?',
      'Medium confidence; select for below-grade drainage where gravity flow isn''t possible.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-134',
      'Drainage',
      'Assessment',
      'Drainage System Inspection & Assessment',
      'On-site assessment of existing drainage issues and recommended solution planning.',
      'project',
      275,
      1,
      1,
      1,
      ARRAY['drainage assessment', 'inspect the drainage', 'figure out the drainage problem', 'drainage consultation']::text[],
      false,
      false,
      true,
      NULL,
      'High confidence when notes describe an unresolved or unclear drainage problem needing diagnosis.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-135',
      'Drainage',
      'Pop-Up Emitter',
      'Pop-Up Emitter Installation',
      'Installation of a pop-up drainage emitter at the discharge end of a French drain or downspout line.',
      'each',
      135,
      1,
      2,
      6,
      ARRAY['pop-up emitter', 'drain outlet', 'discharge point']::text[],
      false,
      false,
      false,
      NULL,
      'Low confidence as a standalone request; typically bundled with a French drain or downspout item.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-136',
      'Landscape Lighting',
      'Fixture',
      'LED Path Light',
      'Supply and installation of a low-voltage LED path light fixture, including wiring to the transformer.',
      'fixture',
      185,
      4,
      10,
      30,
      ARRAY['path light', 'path lighting', 'walkway light']::text[],
      false,
      true,
      false,
      'How many path lights are needed, and which fixture finish is preferred?',
      'High confidence when notes mention path or walkway lighting.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-137',
      'Landscape Lighting',
      'Fixture',
      'LED Uplight',
      'Supply and installation of a low-voltage LED uplight fixture for accenting trees, walls, or architecture.',
      'fixture',
      165,
      4,
      8,
      25,
      ARRAY['uplight', 'accent light', 'wall wash light', 'tree uplight']::text[],
      false,
      true,
      false,
      'How many uplights are needed, and what will they be highlighting (trees, walls, architecture)?',
      'High confidence when notes mention accenting or uplighting a feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-138',
      'Landscape Lighting',
      'Fixture',
      'Tree Lighting (Per Fixture)',
      'Supply and installation of an uplight fixture mounted to illuminate a specific tree.',
      'fixture',
      210,
      2,
      4,
      12,
      ARRAY['tree lighting', 'tree uplight', 'light the palm trees']::text[],
      false,
      false,
      false,
      'How many trees need lighting fixtures?',
      'High confidence when notes mention lighting specific trees or palms.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-139',
      'Landscape Lighting',
      'Fixture',
      'Wall Lighting Fixture',
      'Supply and installation of a surface-mounted or recessed wall lighting fixture.',
      'fixture',
      195,
      2,
      6,
      20,
      ARRAY['wall light', 'wall sconce', 'wall-mounted fixture']::text[],
      false,
      true,
      false,
      'How many wall fixtures are needed, and which finish is preferred?',
      'Medium confidence; select when notes mention lighting mounted directly to a wall surface.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-140',
      'Landscape Lighting',
      'Fixture',
      'Step Lighting Fixture',
      'Supply and installation of a recessed step light for stairs or elevation changes.',
      'fixture',
      175,
      2,
      6,
      16,
      ARRAY['step light', 'stair lighting', 'riser light']::text[],
      false,
      false,
      false,
      'How many steps need lighting fixtures?',
      'High confidence when notes mention lighting steps or stairs.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-141',
      'Landscape Lighting',
      'Equipment',
      'Low-Voltage Transformer',
      'Supply and installation of a low-voltage transformer sized to the lighting fixture load.',
      'each',
      625,
      1,
      1,
      2,
      ARRAY['transformer', 'lighting transformer', 'low voltage power supply']::text[],
      false,
      false,
      false,
      NULL,
      'Low confidence as a standalone request; typically bundled with a lighting package.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-142',
      'Landscape Lighting',
      'Package',
      'Landscape Lighting Package - Small (6-8 fixtures)',
      'Design-build low-voltage lighting package including transformer, wiring, and 6-8 fixtures.',
      'project',
      2450,
      1,
      1,
      1,
      ARRAY['small lighting package', 'basic landscape lighting', 'starter lighting package']::text[],
      false,
      true,
      false,
      'Roughly how many areas of the yard need lighting, and is there a priority feature to highlight first?',
      'Medium confidence; select when notes ask for lighting generally without specifying fixture count.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-143',
      'Landscape Lighting',
      'Package',
      'Landscape Lighting Package - Large (15-20 fixtures)',
      'Design-build low-voltage lighting package including transformer, wiring, and 15-20 fixtures across the yard.',
      'project',
      5800,
      1,
      1,
      1,
      ARRAY['full lighting package', 'whole yard lighting', 'large landscape lighting']::text[],
      false,
      true,
      false,
      'Roughly how many areas of the yard need lighting, and is there a priority feature to highlight first?',
      'Medium confidence; select when notes describe comprehensive lighting across the whole property.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-144',
      'Landscape Lighting',
      'Controls',
      'Lighting Control System Upgrade (App/Smart Control)',
      'Upgrade of landscape lighting to a smart, app-controlled or scheduled dimming system.',
      'each',
      875,
      1,
      1,
      1,
      ARRAY['smart lighting control', 'app-controlled lights', 'lighting automation']::text[],
      false,
      false,
      false,
      NULL,
      'High confidence when notes mention app-based or smart control for landscape lighting.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-145',
      'Landscape Lighting',
      'Controls',
      'Lighting Timer/Photocell Installation',
      'Installation of a basic timer or photocell sensor for automatic dusk-to-dawn lighting control.',
      'each',
      135,
      1,
      1,
      1,
      ARRAY['light timer', 'photocell', 'dusk to dawn sensor']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; select when notes mention automatic on/off lighting without full smart control.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-146',
      'Outdoor Electrical',
      'Circuit',
      'Outdoor Electrical Circuit Run',
      'Trenching and wiring of a new dedicated outdoor electrical circuit from the main panel.',
      'linear_ft',
      18,
      20,
      60,
      200,
      ARRAY['run electrical', 'electrical trench', 'new outdoor circuit', 'power run to the patio']::text[],
      true,
      false,
      true,
      'How far does the new circuit need to run, and what will it power?',
      'High confidence when notes mention needing power run to a new outdoor feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-147',
      'Outdoor Electrical',
      'Outlet',
      'GFCI Outlet Installation',
      'Installation of a code-required weatherproof GFCI outlet in an outdoor location.',
      'each',
      225,
      1,
      2,
      6,
      ARRAY['outdoor outlet', 'gfci outlet', 'weatherproof outlet']::text[],
      false,
      false,
      true,
      'How many outdoor outlets are needed, and where should they be located?',
      'High confidence when notes mention needing an outlet in a specific outdoor location.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-148',
      'Outdoor Electrical',
      'Panel',
      'Outdoor Sub-Panel Installation',
      'Installation of a dedicated outdoor electrical sub-panel to support multiple new circuits.',
      'each',
      1850,
      1,
      1,
      1,
      ARRAY['sub panel', 'electrical panel upgrade', 'outdoor breaker panel']::text[],
      false,
      false,
      true,
      'How many new circuits are planned that would run off this sub-panel?',
      'Medium confidence; select when the scope includes several electrical items (kitchen, lighting, water feature).',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-149',
      'Outdoor Electrical',
      'Circuit',
      '220V Circuit for Outdoor Kitchen Appliance',
      'Installation of a dedicated 220V circuit for a high-draw outdoor kitchen appliance.',
      'each',
      685,
      1,
      1,
      3,
      ARRAY['220v circuit', 'appliance circuit', 'high voltage outlet']::text[],
      false,
      false,
      true,
      'Which appliance requires the 220V circuit?',
      'High confidence when notes mention a specific 220V appliance like certain refrigeration or cooking units.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-150',
      'Outdoor Electrical',
      'Circuit',
      'Outdoor Fan/Heater Electrical Rough-In',
      'Rough-in wiring and switch installation to support a pergola fan or patio heater.',
      'each',
      375,
      1,
      1,
      3,
      ARRAY['fan wiring', 'heater electrical', 'patio heater hookup']::text[],
      false,
      false,
      true,
      'How many fans or heaters need electrical rough-in?',
      'Medium confidence; typically bundled with a fan or heater installation item.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-151',
      'Outdoor Electrical',
      'Lighting',
      'Landscape Lighting Electrical Rough-In',
      'Rough-in of a dedicated circuit and timer connection to support a landscape lighting transformer.',
      'project',
      650,
      1,
      1,
      1,
      ARRAY['lighting circuit', 'landscape lighting power', 'transformer wiring']::text[],
      false,
      false,
      true,
      NULL,
      'Medium confidence; typically bundled automatically with a landscape lighting package.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-152',
      'Outdoor Electrical',
      'Permitting',
      'Electrical Permit & Inspection Coordination',
      'Coordination of permit filing and inspection scheduling for electrical work requiring city approval.',
      'project',
      425,
      1,
      1,
      1,
      ARRAY['electrical permit', 'permit coordination', 'inspection scheduling']::text[],
      false,
      false,
      true,
      NULL,
      'Medium confidence; select automatically when the scope includes a sub-panel or major circuit work.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-153',
      'Planting',
      'Trees',
      'Palm Tree Installation - Standard (8-10ft)',
      'Supply and installation of a standard 8-10 foot palm tree, including staking.',
      'each',
      875,
      1,
      2,
      8,
      ARRAY['palm tree', 'small palm', 'standard palm tree']::text[],
      false,
      true,
      true,
      'How many palm trees are needed, and which variety is preferred?',
      'High confidence when notes mention palm trees without specifying a mature/large size.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-154',
      'Planting',
      'Trees',
      'Palm Tree Installation - Mature (14ft+)',
      'Supply and installation of a mature 14-foot-plus palm tree requiring crane placement.',
      'each',
      2650,
      1,
      1,
      4,
      ARRAY['mature palm tree', 'large palm', 'tall palm tree', 'crane palm']::text[],
      false,
      true,
      true,
      'How many mature palms are needed, and is crane access available at the planting site?',
      'Medium confidence; select when notes emphasize a tall, mature, or statement palm tree.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-155',
      'Planting',
      'Trees',
      'Shade Tree Installation - 24" Box',
      'Supply and installation of a 24-inch box shade tree, including staking and root barrier if needed.',
      'each',
      525,
      1,
      3,
      10,
      ARRAY['shade tree', '24 inch box tree', 'medium tree']::text[],
      false,
      true,
      true,
      'How many shade trees are needed, and which species is preferred?',
      'Medium confidence; select for general shade tree requests without a size qualifier.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-156',
      'Planting',
      'Trees',
      'Shade Tree Installation - 36" Box',
      'Supply and installation of a larger 36-inch box shade tree for more immediate canopy coverage.',
      'each',
      1150,
      1,
      2,
      6,
      ARRAY['large shade tree', '36 inch box tree', 'big tree']::text[],
      false,
      true,
      true,
      'How many large shade trees are needed, and which species is preferred?',
      'Medium confidence; select when notes emphasize immediate shade or a larger starting tree size.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-157',
      'Planting',
      'Package',
      'Desert Planting Package - Small Bed',
      'Curated desert-adapted plant package (agave, yucca, accent shrubs) for a single planting bed.',
      'sqft',
      8.5,
      50,
      200,
      800,
      ARRAY['desert plants', 'xeriscape planting', 'small planting bed', 'desert landscaping']::text[],
      true,
      true,
      true,
      'How many square feet of planting bed, and any color or plant preferences?',
      'Medium confidence; select for a defined single bed rather than the whole yard.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-158',
      'Planting',
      'Package',
      'Desert Planting Package - Full Yard',
      'Curated desert-adapted plant package sized for full-yard xeriscape planting.',
      'sqft',
      6.25,
      500,
      2000,
      6000,
      ARRAY['full yard planting', 'whole yard xeriscape', 'complete desert landscaping']::text[],
      true,
      true,
      true,
      'How many total square feet of planting coverage are needed across the yard?',
      'Medium confidence; select when notes describe planting the entire yard rather than one bed.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-159',
      'Planting',
      'Cactus',
      'Cactus Installation - Accent (Barrel/Golden Barrel)',
      'Supply and installation of an accent-size barrel or golden barrel cactus.',
      'each',
      145,
      2,
      8,
      30,
      ARRAY['barrel cactus', 'golden barrel', 'accent cactus']::text[],
      false,
      false,
      true,
      'How many accent cacti are needed?',
      'High confidence when notes mention barrel cactus or similar small accent cacti.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-160',
      'Planting',
      'Cactus',
      'Cactus Installation - Specimen (Saguaro)',
      'Supply and installation of a specimen saguaro cactus, including permitting coordination if required.',
      'each',
      2850,
      1,
      1,
      3,
      ARRAY['saguaro', 'specimen cactus', 'large cactus']::text[],
      false,
      false,
      true,
      'How many saguaros are needed, and what height range is preferred?',
      'High confidence when notes specifically mention a saguaro.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-161',
      'Planting',
      'Shrubs',
      'Shrub Installation - 5-Gallon',
      'Supply and installation of a standard 5-gallon container shrub.',
      'each',
      65,
      5,
      25,
      100,
      ARRAY['shrubs', '5 gallon shrub', 'small shrub', 'bushes']::text[],
      false,
      true,
      false,
      'How many shrubs are needed, and is there a variety preference?',
      'High confidence when notes mention shrubs or bushes generally.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-162',
      'Planting',
      'Shrubs',
      'Shrub Installation - 15-Gallon',
      'Supply and installation of a larger 15-gallon container shrub for more immediate screening or fill.',
      'each',
      185,
      3,
      10,
      40,
      ARRAY['large shrub', '15 gallon shrub', 'big bush']::text[],
      false,
      true,
      false,
      'How many larger shrubs are needed, and is there a variety preference?',
      'Medium confidence; select when notes emphasize immediate size or privacy screening.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-163',
      'Planting',
      'Groundcover',
      'Groundcover Installation',
      'Supply and installation of flat or spreading groundcover plants across a planting area.',
      'sqft',
      3.75,
      50,
      300,
      1000,
      ARRAY['groundcover', 'ground cover plants', 'low spreading plants']::text[],
      true,
      true,
      false,
      'How many square feet of groundcover are needed, and is there a preferred variety?',
      'Medium confidence; select when notes mention low, spreading, or filler planting.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-164',
      'Planting',
      'Accent',
      'Accent Plant Installation (Agave/Yucca)',
      'Supply and installation of an architectural accent plant such as agave or yucca.',
      'each',
      85,
      3,
      12,
      40,
      ARRAY['agave', 'yucca', 'accent plant', 'architectural plant']::text[],
      false,
      true,
      false,
      'How many accent plants are needed?',
      'High confidence when notes mention agave, yucca, or similar architectural accent plants.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-165',
      'Planting',
      'Vine',
      'Vine/Espalier Planting',
      'Supply and installation of a climbing vine or espalier-trained plant along a wall or trellis.',
      'each',
      95,
      1,
      4,
      12,
      ARRAY['vine', 'climbing plant', 'espalier', 'trellis plant']::text[],
      false,
      true,
      false,
      'How many vines are needed, and what will they be climbing (wall, trellis, fence)?',
      'Medium confidence; select when notes mention greenery climbing a wall, fence, or trellis.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-166',
      'Planting',
      'Prep',
      'Planting Bed Soil Prep & Amendment',
      'Excavation, amendment, and preparation of soil within a planting bed prior to installing plant material.',
      'sqft',
      2.85,
      50,
      300,
      1000,
      ARRAY['soil prep for plants', 'bed prep', 'amend the soil for planting']::text[],
      true,
      false,
      true,
      'How many square feet of planting bed need soil preparation?',
      'Medium confidence; typically bundled with a planting package rather than requested separately.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-167',
      'Fencing & Gates',
      'Fence',
      'View Fence - Wrought Iron Style',
      'Installation of a powder-coated tubular steel view fence for pool code compliance or property lines.',
      'linear_ft',
      85,
      20,
      100,
      400,
      ARRAY['view fence', 'wrought iron fence', 'iron fencing', 'pool fence']::text[],
      true,
      true,
      true,
      'How many linear feet of view fence are needed, and what height?',
      'High confidence when notes mention a see-through, iron-style, or pool safety fence.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-168',
      'Fencing & Gates',
      'Fence',
      'Privacy Fence - Wood',
      'Installation of a wood privacy fence with posts set in concrete.',
      'linear_ft',
      58,
      20,
      100,
      400,
      ARRAY['wood fence', 'wood privacy fence', 'wooden fencing']::text[],
      true,
      true,
      true,
      'How many linear feet of wood fence are needed, and what height?',
      'High confidence when notes mention a wood or wooden privacy fence.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-169',
      'Fencing & Gates',
      'Fence',
      'Privacy Fence - Vinyl',
      'Installation of a low-maintenance vinyl privacy fence with posts set in concrete.',
      'linear_ft',
      72,
      20,
      100,
      400,
      ARRAY['vinyl fence', 'pvc fence', 'vinyl privacy fence']::text[],
      true,
      true,
      true,
      'How many linear feet of vinyl fence are needed, and what height?',
      'High confidence when notes mention a vinyl or PVC privacy fence.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-170',
      'Fencing & Gates',
      'Fence',
      'Block Wall Fence',
      'Construction of a masonry block wall serving as a property line fence.',
      'linear_ft',
      95,
      20,
      100,
      400,
      ARRAY['block fence', 'cinder block wall', 'masonry fence', 'cmu wall']::text[],
      true,
      true,
      true,
      'How many linear feet of block wall fencing are needed, and what height?',
      'High confidence when notes mention a block or masonry fence at the property line.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-171',
      'Fencing & Gates',
      'Fence',
      'Pool Safety Fence',
      'Installation of a code-compliant self-closing pool safety fence around the pool area.',
      'linear_ft',
      68,
      20,
      60,
      200,
      ARRAY['pool safety fence', 'pool code fence', 'child safety fence']::text[],
      true,
      true,
      true,
      'How many linear feet of pool safety fence are needed, and does it need to meet a specific city code?',
      'High confidence when notes mention pool safety, code compliance, or child-safety fencing.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-172',
      'Fencing & Gates',
      'Gate',
      'Single Walk Gate',
      'Supply and installation of a single pedestrian walk gate matching the adjoining fence style.',
      'each',
      625,
      1,
      1,
      4,
      ARRAY['walk gate', 'single gate', 'pedestrian gate', 'side gate']::text[],
      false,
      true,
      false,
      'How many walk gates are needed, and which fence style should they match?',
      'High confidence when notes mention a walk-through or side gate.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-173',
      'Fencing & Gates',
      'Gate',
      'Double Drive Gate',
      'Supply and installation of a double-panel drive gate sized for vehicle access.',
      'each',
      1850,
      1,
      1,
      2,
      ARRAY['drive gate', 'double gate', 'vehicle gate', 'driveway gate']::text[],
      true,
      true,
      true,
      'What is the required opening width for the drive gate?',
      'High confidence when notes mention a driveway or vehicle-access gate.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-174',
      'Fencing & Gates',
      'Gate',
      'Automatic Gate Opener',
      'Installation of an automatic gate opener system with remote or keypad access.',
      'each',
      2450,
      1,
      1,
      1,
      ARRAY['automatic gate', 'gate opener', 'electric gate', 'keypad gate']::text[],
      false,
      false,
      true,
      'Is power already available near the gate location?',
      'High confidence when notes mention an automatic, electric, or remote-controlled gate.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-175',
      'Fencing & Gates',
      'Hardware',
      'Gate Hardware Upgrade (Self-Closing/Latch)',
      'Upgrade of gate hardware to a self-closing hinge and code-compliant latch.',
      'each',
      145,
      1,
      1,
      4,
      ARRAY['gate hardware', 'self-closing hinge', 'gate latch upgrade']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; often required for pool code compliance on an existing gate.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-176',
      'Fencing & Gates',
      'Demolition',
      'Fence Demolition & Removal',
      'Removal and haul-off of an existing fence, including posts.',
      'linear_ft',
      12,
      20,
      100,
      400,
      ARRAY['remove old fence', 'fence demo', 'tear out the fence', 'fence removal']::text[],
      true,
      false,
      true,
      'How many linear feet of existing fence need to be removed?',
      'High confidence when notes mention removing or replacing an existing fence.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-177',
      'Decorative Features',
      'Fireplace',
      'Outdoor Fireplace - Masonry',
      'Construction of a full masonry outdoor fireplace with chimney and gas or wood-burning firebox.',
      'each',
      9800,
      1,
      1,
      1,
      ARRAY['outdoor fireplace', 'masonry fireplace', 'backyard fireplace']::text[],
      true,
      true,
      true,
      'Should the fireplace be gas or wood-burning, and what size/style is preferred?',
      'High confidence when notes specifically mention a fireplace rather than a fire pit.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-178',
      'Decorative Features',
      'Media',
      'Outdoor TV Nook / Media Wall',
      'Construction of a weather-protected media wall niche designed to house an outdoor television.',
      'each',
      4200,
      1,
      1,
      1,
      ARRAY['outdoor tv', 'media wall', 'tv nook', 'outdoor entertainment wall']::text[],
      true,
      true,
      true,
      'What TV size should the nook be built to accommodate, and is power/cable already run nearby?',
      'High confidence when notes mention an outdoor TV or media wall feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-179',
      'Decorative Features',
      'Concrete',
      'Decorative Concrete Overlay',
      'Application of a thin decorative concrete overlay to refresh an existing worn concrete surface.',
      'sqft',
      8.75,
      100,
      500,
      2000,
      ARRAY['concrete overlay', 'resurface the concrete', 'concrete refinish']::text[],
      true,
      true,
      true,
      'How many square feet of existing concrete need a decorative overlay, and what is its current condition?',
      'High confidence when notes mention resurfacing or refreshing existing concrete rather than a new pour.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-180',
      'Decorative Features',
      'Art',
      'Custom Metal Art Panel',
      'Design and installation of a custom laser-cut metal art panel as a wall or fence accent.',
      'each',
      1450,
      1,
      1,
      4,
      ARRAY['metal art', 'laser cut panel', 'decorative metal screen', 'art panel']::text[],
      true,
      true,
      false,
      'What size and design theme is preferred for the metal art panel?',
      'Medium confidence; select when notes mention custom art, a metal screen, or a decorative accent panel.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-181',
      'Decorative Features',
      'Signage',
      'Address/House Number Sign - Lit',
      'Supply and installation of an illuminated custom address sign at the entry or curb.',
      'each',
      385,
      1,
      1,
      1,
      ARRAY['address sign', 'house number sign', 'lit address plaque']::text[],
      false,
      true,
      true,
      NULL,
      'High confidence when notes mention an address sign or house numbers as a feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-182',
      'Decorative Features',
      'Border',
      'Decorative Gravel Bed Border',
      'Installation of a narrow decorative gravel border strip along a wall, fence, or planting bed edge.',
      'linear_ft',
      11,
      15,
      50,
      200,
      ARRAY['gravel border', 'decorative border strip', 'accent gravel edge']::text[],
      true,
      true,
      false,
      'How many linear feet of gravel border are needed?',
      'Medium confidence; typically bundled as an accent detail with a larger rock or planting item.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-183',
      'Decorative Features',
      'Seating',
      'Custom Bench/Seating Feature',
      'Construction of a custom built-in bench or seating feature using matching hardscape materials.',
      'linear_ft',
      165,
      4,
      10,
      30,
      ARRAY['built-in bench', 'custom seating', 'outdoor bench']::text[],
      true,
      true,
      false,
      'How many linear feet of custom bench seating are needed?',
      'Medium confidence; select when notes mention a built-in bench distinct from a seat wall.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-184',
      'Decorative Features',
      'Path',
      'Stepping Stone Path',
      'Installation of individual stepping stones set into a rock, mulch, or planting area to form an informal path.',
      'each',
      45,
      8,
      20,
      60,
      ARRAY['stepping stones', 'stone path', 'informal walkway']::text[],
      false,
      true,
      false,
      'How many stepping stones are needed, and roughly how long is the path?',
      'High confidence when notes mention stepping stones specifically rather than a paved walkway.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-185',
      'Decorative Features',
      'Planter',
      'Planter Box - Built-In Masonry',
      'Construction of a built-in masonry planter box matching surrounding hardscape materials.',
      'each',
      625,
      1,
      2,
      6,
      ARRAY['planter box', 'built-in planter', 'masonry planter']::text[],
      false,
      true,
      false,
      'How many planter boxes are needed, and what size?',
      'Medium confidence; select when notes mention a built-in or raised planter feature.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-186',
      'Synthetic Landscaping',
      'Hedge',
      'Synthetic Boxwood Hedge Panel',
      'Installation of artificial boxwood hedge panels mounted to a frame or existing fence for year-round greenery.',
      'sqft',
      22,
      10,
      40,
      150,
      ARRAY['fake hedge', 'artificial boxwood', 'synthetic hedge panel', 'faux boxwood wall']::text[],
      true,
      false,
      false,
      'How many square feet of synthetic hedge panel are needed, and what will it be mounted to?',
      'High confidence when notes mention fake or artificial boxwood/hedge panels.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-187',
      'Synthetic Landscaping',
      'Wall',
      'Artificial Vine/Greenery Wall',
      'Installation of an artificial greenery or vine wall panel system for permanent green coverage.',
      'sqft',
      18.5,
      10,
      40,
      150,
      ARRAY['fake vine wall', 'artificial greenery wall', 'green wall', 'faux plant wall']::text[],
      true,
      false,
      false,
      'How many square feet of greenery wall are needed?',
      'High confidence when notes mention a fake or artificial green wall/vine coverage.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-188',
      'Synthetic Landscaping',
      'Putting Green',
      'Synthetic Putting Green Cup & Flag Package',
      'Supply and installation of a regulation cup and flag package for a synthetic putting green.',
      'each',
      325,
      1,
      1,
      4,
      ARRAY['putting green cups', 'golf flag package', 'putting cup and flag']::text[],
      false,
      false,
      false,
      'How many cups/flags are needed for the putting green?',
      'Medium confidence; typically bundled with a putting green turf installation.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-189',
      'Synthetic Landscaping',
      'Screening',
      'Faux Rock Cover (Utility Screening)',
      'Installation of a lightweight faux rock enclosure to screen pool equipment, utility boxes, or wellheads.',
      'each',
      285,
      1,
      2,
      6,
      ARRAY['fake rock cover', 'faux rock', 'equipment screening rock', 'hide the pool equipment']::text[],
      false,
      true,
      true,
      'How many pieces of equipment need to be screened, and what are their approximate dimensions?',
      'High confidence when notes mention hiding or screening pool/utility equipment with a rock cover.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-190',
      'Synthetic Landscaping',
      'Fence Screening',
      'Synthetic Ivy Fence Screening',
      'Installation of synthetic ivy screening panels attached to an existing chain-link or view fence.',
      'linear_ft',
      16,
      20,
      80,
      300,
      ARRAY['fake ivy screening', 'synthetic ivy fence', 'artificial ivy privacy']::text[],
      true,
      false,
      false,
      'How many linear feet of fence need ivy screening?',
      'High confidence when notes mention fake ivy or synthetic screening on an existing fence.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-191',
      'Synthetic Landscaping',
      'Topiary',
      'Artificial Topiary Installation',
      'Supply and installation of artificial topiary plants or spiral shrubs as an entry or accent feature.',
      'each',
      195,
      1,
      4,
      12,
      ARRAY['fake topiary', 'artificial spiral shrub', 'faux topiary']::text[],
      false,
      true,
      false,
      'How many artificial topiaries are needed?',
      'High confidence when notes mention fake or artificial topiary specifically.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-192',
      'Maintenance',
      'Recurring',
      'Monthly Landscape Maintenance - Standard',
      'Recurring monthly maintenance visit covering mowing, trimming, weeding, and basic upkeep.',
      'month',
      185,
      1,
      12,
      12,
      ARRAY['monthly maintenance', 'lawn service', 'yard maintenance', 'landscape upkeep']::text[],
      false,
      false,
      false,
      NULL,
      'High confidence when notes mention ongoing or recurring landscape maintenance.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-193',
      'Maintenance',
      'Recurring',
      'Monthly Landscape Maintenance - Premium',
      'Recurring monthly maintenance visit including standard upkeep plus irrigation checks and seasonal color rotation.',
      'month',
      325,
      1,
      12,
      12,
      ARRAY['premium maintenance', 'full service maintenance', 'all-inclusive yard care']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; select when notes mention a more comprehensive or full-service maintenance plan.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-194',
      'Maintenance',
      'Irrigation',
      'Irrigation Seasonal Tune-Up',
      'Seasonal inspection and adjustment of irrigation zones, heads, and controller settings.',
      'project',
      150,
      1,
      1,
      1,
      ARRAY['sprinkler tune-up', 'seasonal irrigation check', 'irrigation checkup']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; select for a one-time irrigation check rather than full system service.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-195',
      'Maintenance',
      'Turf',
      'Turf Cleaning & Infill Refresh',
      'Deep cleaning, grooming, and infill top-off service for existing artificial turf.',
      'sqft',
      0.65,
      300,
      800,
      2500,
      ARRAY['turf cleaning', 'refresh the turf', 'turf maintenance', 'turf grooming']::text[],
      false,
      false,
      false,
      'How many square feet of existing turf need cleaning/refresh service?',
      'High confidence when notes mention cleaning or refreshing existing artificial turf.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-196',
      'Maintenance',
      'Lighting',
      'Landscape Lighting Bulb/Fixture Service',
      'Service visit to replace bulbs, adjust aim, and troubleshoot an existing landscape lighting system.',
      'project',
      175,
      1,
      1,
      1,
      ARRAY['lighting service', 'fix the landscape lights', 'replace light bulbs', 'lighting troubleshooting']::text[],
      false,
      false,
      false,
      NULL,
      'High confidence when notes describe an existing lighting system with bulbs out or fixtures malfunctioning.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-197',
      'Add-ons & Upgrades',
      'Design',
      'Design Consultation & 3D Rendering',
      'Design consultation including a 3D rendering of the proposed project for client visualization.',
      'project',
      650,
      1,
      1,
      1,
      ARRAY['3d rendering', 'design consultation', 'design rendering', 'visualize the project']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; select when notes mention wanting to see a rendering or design plan before approval.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-198',
      'Add-ons & Upgrades',
      'Scheduling',
      'Expedited Project Scheduling',
      'Priority scheduling fee to move a project ahead in the installation queue.',
      'project',
      1200,
      1,
      1,
      1,
      ARRAY['rush job', 'expedited schedule', 'priority scheduling', 'fast track the project']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; select when notes mention urgency, a deadline, or wanting the project rushed.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-199',
      'Add-ons & Upgrades',
      'Warranty',
      'Extended Warranty Upgrade',
      'Upgrade from the standard workmanship warranty to an extended multi-year coverage period.',
      'project',
      850,
      1,
      1,
      1,
      ARRAY['extended warranty', 'warranty upgrade', 'longer warranty']::text[],
      false,
      false,
      false,
      NULL,
      'Medium confidence; select when notes mention wanting additional warranty coverage.',
      true
    );
INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      'GP-200',
      'Add-ons & Upgrades',
      'Service',
      'Post-Installation Walkthrough & Touch-Up Visit',
      'Scheduled follow-up visit after project completion to address touch-ups and answer client questions.',
      'project',
      225,
      1,
      1,
      1,
      ARRAY['final walkthrough', 'touch-up visit', 'post-installation check', 'follow-up visit']::text[],
      false,
      false,
      false,
      NULL,
      'Low confidence as a standalone request; typically included automatically on larger projects.',
      true
    );