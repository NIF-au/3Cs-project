#!/bin/bash

nii2mnc $1 CTmnc.mnc

nii2mnc $2  MRImnc.mnc;

register MRImnc.mnc CTmnc.mnc
