import Joi from "joi";

export const problemSchema = Joi.object({
  title: Joi.string().required(),
  description: Joi.string().required(),
  difficulty: Joi.string().required(),
  sampleTestCase: Joi.object({
    input: Joi.string().required(),
    output: Joi.string().required(),
  }).required(),
  time: Joi.number().required(),
  memory: Joi.number().required(),
});

export const testCaseSchema = Joi.object({
    input: Joi.string().required(),
    output: Joi.string().required(),
})